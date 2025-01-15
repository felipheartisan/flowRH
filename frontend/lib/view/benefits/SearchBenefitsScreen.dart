import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/repositories/beneficios_funcionarios_repository.dart';
import 'package:flow_rh/domain/repositories/beneficios_repository.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import 'FormBenefitsScreen.dart';

class SearchBenefitsScreen extends StatefulWidget{

  static const String routName = "search.benefits";

  const SearchBenefitsScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _SearchBenefitsScreenState();
}
  
class _SearchBenefitsScreenState extends State<SearchBenefitsScreen> {

  List<Beneficio> _results = [];
  List<Beneficio> _results_filtred = [];

  List<BeneficiosFuncionarios> all_funcBene = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late BeneficiosRepository beneficiosRepository;
  late BeneficiosFuncionariosRepository funcbeneRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    beneficiosRepository = BeneficiosRepository(databaseProvider);
    funcbeneRepository = BeneficiosFuncionariosRepository(databaseProvider);
    
    _results = await beneficiosRepository.findAll();
    List<Beneficio> res = await beneficiosRepository.findAll();

    all_funcBene = await funcbeneRepository.findAll();
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Beneficios Cadastrados",
      routNameForm: FormBenefitsScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
      );
  }

  Widget _createItem(BuildContext context, int index) {
     return Card(
      color: Colors.blue,
      child: ListTile(
        
        title: Text(_results_filtred[index].descricao!),
        leading: IconButton(icon: const Icon(Icons.delete),
        onPressed: () async {
          Beneficio beneficio = _results_filtred[index];
          beneficiosRepository.delete(beneficio);
          // List<Beneficio> res = await beneficiosRepository.findAll();
          // setState(() {
          //   _results = res;
          // });
          await _buscarTodos();
        },
       ),
       onTap: () async {
        Beneficio beneficio = _results_filtred[index];
        print(beneficio);
        await Navigator.of(context).pushNamed(FormBenefitsScreen.routName, arguments: beneficio);
        // List<Beneficio> res = await beneficiosRepository.findAll();
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
    List<Beneficio> res = await beneficiosRepository.findAll();
    setState(() {
        _results = res;
        _results_filtred = res;
    });
  }

  void _filtrar(String value){
    List<Beneficio> res = [];
    if (value.isEmpty){
      _results_filtred = _results;
    }else{
      res = _results
          .where((item) => item.descricao!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
      _results_filtred = res;
    });
    }
  }

  // void _delete(beneficio){

  //   BeneficiosFuncionarios funcBene = BeneficiosFuncionarios();
    
    

  //   for (funcBene in all_funcBene){
  //     if (funcBene.idBeneficios == beneficio.idBeneficios){
  //       funcbeneRepository.delete(funcBene);
  //     }
  //   }

  //   beneficiosRepository.delete(beneficio);
  // }


}