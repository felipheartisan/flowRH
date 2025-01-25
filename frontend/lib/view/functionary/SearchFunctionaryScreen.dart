import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/domain/repositories/beneficios_funcionarios_repository.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/functionary/FormFunctionaryScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchFunctionaryScreen extends StatefulWidget{
  static const String routName = "search.functionary";

  const SearchFunctionaryScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _SearchFunctionaryScreenState();
}

class _SearchFunctionaryScreenState extends State<SearchFunctionaryScreen> {
  List<Funcionario> _results = [];
  List<Funcionario> _results_filtred = [];

  List<Avaliacao> all_avaliacoes = [];
  List<BeneficiosFuncionarios> all_funcBene = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late FuncionarioRepository funcionarioRepository;
  late AvaliacoesRepository avaliacoesRepository;
  late BeneficiosFuncionariosRepository funcbeneRepository;

  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    funcionarioRepository = FuncionarioRepository(databaseProvider);
    avaliacoesRepository = AvaliacoesRepository(databaseProvider);
    funcbeneRepository = BeneficiosFuncionariosRepository(databaseProvider);

    List<Funcionario> res = await funcionarioRepository.findAll();

    all_avaliacoes = await avaliacoesRepository.findAll();
    all_funcBene = await funcbeneRepository.findAll();

    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return SearchWidget(
      title: "Colaboradores",
      routNameForm: FormFunctionaryScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
      );
  }

  Widget _createItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(_results_filtred[index].nome!),
        leading: IconButton(icon: const Icon(Icons.delete),
        onPressed: () async {
          Funcionario funcionario = _results_filtred[index];
          funcionarioRepository.delete(funcionario);
          // List<Funcionario> res = await funcionarioRepository.findAll();
          // setState(() {
          //   _results = res;
          // });
          await _buscarTodos();
        },
       ),
       onTap: () async {
        Funcionario funcionario = _results_filtred[index];
        print(funcionario);
        await Navigator.of(context).pushNamed(FormFunctionaryScreen.routName, arguments: funcionario);
        // List<Funcionario> res = await funcionarioRepository.findAll();
        // setState(() {
        //   _results = res;
        // });
        await _buscarTodos();
       },
      ),
    );
  }

  Future<void> _buscarTodos() async {
        //Atualiza a lista de pesquisa novamente
    List<Funcionario> res = await funcionarioRepository.findAll();
    setState(() {
        _results = res;
        _results_filtred = res;
    });
  }

 void _filtrar(String value){
    List<Funcionario> res = [];
    if (value.isEmpty){
      _results_filtred = _results;
    }else{
      res = _results
          .where((item) => item.nome!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
      _results_filtred = res;
    });
    }
  }

//  void _delete(funcionario){
      
//     Avaliacao avaliacao = Avaliacao();
//     BeneficiosFuncionarios funcBene = BeneficiosFuncionarios();
    
    
//     for (avaliacao in all_avaliacoes){
//       if (avaliacao.IdFuncionarios == funcionario.idFuncionarios){
//         avaliacoesRepository.delete(avaliacao);
//       }
//     }

//     for (funcBene in all_funcBene){
//       if (funcBene.idFuncionarios == funcionario.idFuncionarios){
//         funcbeneRepository.delete(funcBene);
//       }
//     }

//     funcionarioRepository.delete(funcionario);
//   }

  
}

