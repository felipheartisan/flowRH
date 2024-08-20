import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/domain/repositories/beneficios_funcionarios_repository.dart';
import 'package:flow_rh/view/functionary_benefits/FormFuncBene.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SearchfuncbeneScreen extends StatefulWidget{
   static const String routName = "search.funcbenefit";

   @override
   _SearchfuncbenefitScreenState createState() => _SearchfuncbenefitScreenState();

}

class _SearchfuncbenefitScreenState extends State<SearchfuncbeneScreen>{
  List<BeneficiosFuncionarios> _results = [];
  List<BeneficiosFuncionarios> _results_filtred = [];
  
  DatabaseProvider databaseProvider = DatabaseProvider();
  late BeneficiosFuncionariosRepository beneficiosFuncionariosRepository;

  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    beneficiosFuncionariosRepository = BeneficiosFuncionariosRepository(databaseProvider);
    List<BeneficiosFuncionarios> res = await beneficiosFuncionariosRepository.findAll();

    setState(() {
      _results = res;
      _results_filtred = res;
    });
    
  }

  
  // @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Beneficios & Funcionários'),
//       ),
//       body:       
//             Expanded(
//               child: ListView.builder(itemCount: _results.length, // Número total de itens
//               itemBuilder: (context, index){
//                 final item = _results[index];
//                 return ListTile(
//                   title: Text('Benefício: ${item.beneficio.descricao}, Funcionário: ${item.funcionario.nome}'),
//                 );
//               }
//               )
//     ));
//   }
// }
  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Beneficios & Funcionários",
      routNameForm: FormFuncBeneScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
      );
  }

  Widget _createItem(BuildContext context, int index) {
     return Card(
      child: ListTile(   
        title: Text('Beneficio: ${_results_filtred[index].descricao_beneficio}'+ '\n'+ 
                    'Funcionario: ${_results_filtred[index].nome_funcionario}' ),
        leading: IconButton(icon: Icon(Icons.delete),
        onPressed: () async {
          BeneficiosFuncionarios beneficiosFuncionarios = _results_filtred[index];
          beneficiosFuncionariosRepository.delete(beneficiosFuncionarios);
          
          // List<BeneficiosFuncionarios> res = await beneficiosFuncionariosRepository.findAll();
          // setState(() {
          //   _results = res;
          // });
          await _buscarTodos();
        },
       ),
       onTap: () async {
        BeneficiosFuncionarios beneficiosFuncionarios = _results_filtred[index];
        print(beneficiosFuncionarios);
        await Navigator.of(context).pushNamed(FormFuncBeneScreen.routName, arguments: beneficiosFuncionarios);
        // List<BeneficiosFuncionarios> res = await beneficiosFuncionariosRepository.findAll();
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
    List<BeneficiosFuncionarios> res = await beneficiosFuncionariosRepository.findAll();
    setState(() {
        _results = res;
        _results_filtred = res;
    });
  }

  void _filtrar(String value){
    List<BeneficiosFuncionarios> res = [];

    if (value.isEmpty){
      _results_filtred = _results;
    }else{
       res = _results
          .where((item) => item.nome_funcionario!.toLowerCase().contains(value.toLowerCase()) 
          || item.descricao_beneficio!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _results_filtred = res;
  
    });
    }
  }

 
}
