import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/cash.dart';
import 'package:flow_rh/domain/repositories/cash_repository.dart';
import 'package:flow_rh/view/cashflow/FormCashScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchCashScreen extends StatefulWidget{

  static const String routName = "search.cash";

  const SearchCashScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _SearchCashScreenState();
}
  
class _SearchCashScreenState extends State<SearchCashScreen> {

  List<Cash> _results = [];
  List<Cash> _results_filtred = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late CashRepository cashRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    cashRepository = CashRepository(databaseProvider);
    List<Cash> res = await cashRepository.findAll();
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Fluxo de caixa",
      routNameForm: FormCashScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
      );
  }

  Widget _createItem(BuildContext context, int index) {
     return Card(
      color: (_results_filtred[index].categoria == "Entrada" ? Colors.green : Colors.red),
      child: ListTile(
        
        title: Text('Valor: ${_results_filtred[index].valor}'+ '\n'+ 
                    'Descrição: ${_results_filtred[index].descricao}' +'\n'+ 
                    'Data: ${_results_filtred[index].data}'+'\n'+ 
                    'Categoria: ${_results_filtred[index].categoria}'),
        leading: IconButton(icon: Icon(Icons.delete),
        onPressed: () async {
          Cash cash = _results_filtred[index];
          cashRepository.delete(cash);
          // List<Cash> res = await cashRepository.findAll();
          // setState(() {
          //   _results = res;
          // });
          await _buscarTodos();
        },
       ),
       onTap: () async {
        Cash cash = _results_filtred[index];
        print(cash);
        await Navigator.of(context).pushNamed(FormCashScreen.routName, arguments: cash);
        // List<Cash> res = await cashRepository.findAll();
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
    List<Cash> res = await cashRepository.findAll();
    setState(() {
        _results = res;
        _results_filtred = res;
    });
  }

  void _filtrar(String value){
    List<Cash> res = [];
    if (value.isEmpty){
      _results_filtred = _results;
    }else{
      
       res = _results
          .where((item) => item.categoria!.toLowerCase().contains(value.toLowerCase()) || 
          item.data!.toLowerCase().contains(value.toLowerCase()) || 
          item.descricao!.toLowerCase().contains(value.toLowerCase()) || 
          item.valor!.toString().contains(value)  )
          .toList();
      setState(() {
        _results_filtred = res;
        print(_results_filtred);
    });
    }
  }

}