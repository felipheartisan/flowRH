import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/view/avaliation/FormAvaliationScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchAvaliationScreen extends StatefulWidget{

  static const String routName = "avaliation";

  const SearchAvaliationScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _SearchAvaliationScreenState();
}
  
class _SearchAvaliationScreenState extends State<SearchAvaliationScreen> {

  List<Avaliacao> _results = [];
  List<Avaliacao> _results_filtred = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late AvaliacoesRepository avaliacoesRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    avaliacoesRepository = AvaliacoesRepository(databaseProvider);
    List<Avaliacao> res = await avaliacoesRepository.findAll();
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Avaliações de funcionário",
      routNameForm: FormAvaliationScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
      );
  }

  Widget _createItem(BuildContext context, int index) {
     return Card(
      child: ListTile(
        
        title: Text('Funcionário: ${_results_filtred[index].NomeFuncionario}'+ '\n'+ 
                    'Nota: ${_results_filtred[index].nota}' +'\n'+ 
                    'Mês: ${_results_filtred[index].mesReferencia}'+'\n'+ 
                    'Ano: ${_results_filtred[index].anoReferencia}'),
        leading: IconButton(icon: Icon(Icons.delete),
        onPressed: () async {
          Avaliacao avaliacao = _results_filtred[index];
          avaliacoesRepository.delete(avaliacao);
          // List<Avaliacao> res = await avaliacoesRepository.findAll();
          // setState(() {
          //   _results = res;
          // });
          await _buscarTodos();
        },
       ),
       onTap: () async {
        Avaliacao avaliacao = _results_filtred[index];
        print(avaliacao);
        await Navigator.of(context).pushNamed(FormAvaliationScreen.routName, arguments: avaliacao);
        // List<Avaliacao> res = await avaliacoesRepository.findAll();
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
    List<Avaliacao> res = await avaliacoesRepository.findAll();
    setState(() {
        _results = res;
        _results_filtred = res;
    });
  }

  void _filtrar(String value){
    List<Avaliacao> res = [];
    if (value.isEmpty){
      _results_filtred = _results;
    }else{
       res = _results
          .where((item) => item.NomeFuncionario!.toLowerCase().contains(value.toLowerCase()) ||
          item.mesReferencia!.toLowerCase().contains(value.toLowerCase()) ||
          item.anoReferencia!.toLowerCase().contains(value.toLowerCase()) ||
          item.nota!.toString().contains(value.toLowerCase()) ||
          item.cursosFeitos!.toLowerCase().contains(value.toLowerCase()) ||
          item.cursosInteresse!.toLowerCase().contains(value.toLowerCase())
          )
          .toList();
      setState(() {
        _results_filtred = res;
  
    });
    }
  }
}