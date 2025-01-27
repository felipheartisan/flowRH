import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/lancamento_controller.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/lancamento_model.dart';
import 'package:flow_rh/domain/repositories/lancamento_repository.dart';
import 'package:flow_rh/view/cashflow/FormLancamentoScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchLancamentoScreen extends StatefulWidget {
  static const String routName = "search.Lancamento";

  const SearchLancamentoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchLancamentoScreenState();
}

class _SearchLancamentoScreenState extends State<SearchLancamentoScreen> {
  final LancamentoController lancamentoController =
      LancamentoController(LancamentoRepository(client: HttpClient()));

  List<Lancamento> _results = [];
  List<Lancamento> _results_filtred = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    final response = await lancamentoController.listarLancamentos();
    List<Lancamento> res = response[0].dados ?? [];
    print(res);
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Fluxo de caixa",
      routNameForm: FormLancamentoScreen.routName,
      results: _results_filtred,
      onitemBuilder: (context, index) => _createItem(context, index),
      updateListView: () => _buscarTodos(),
      filtraResultados: (String value) => _filtrar(value),
    );
  }

  Widget _createItem(BuildContext context, int index) {
    return Card(
      color: (_results_filtred[index].tipo == "Entrada"
          ? Colors.green
          : Colors.red),
      child: ListTile(
        title: Text('Valor: ${_results_filtred[index].valor}' '\n' +
            'Descrição: ${_results_filtred[index].descricao}' +
            '\n' +
            'Data: ${_results_filtred[index].data}' +
            '\n' +
            'Categoria: ${_results_filtred[index].tipo}'),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            Lancamento lancamento = _results_filtred[index];
            final response =
                await lancamentoController.deletarFuncionario(lancamento.id!);

            //beneficiosRepository.delete(beneficio);

            List<Lancamento> res = response[0].dados ?? [];
            print(res);
            setState(() {
              _results = res;
              _results_filtred = res;
            });
            await _buscarTodos();
          },
        ),
        onTap: () async {
          Lancamento lancamento = _results_filtred[index];

          await Navigator.of(context)
              .pushNamed(FormLancamentoScreen.routName, arguments: lancamento);
          final response = await lancamentoController.listarLancamentos();
          List<Lancamento> res = response[0].dados ?? [];
          print(res);
          setState(() {
            _results = res;
            _results_filtred = res;
          });
          await _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    final response = await lancamentoController.listarLancamentos();
    List<Lancamento> res = response[0].dados ?? [];
    print(res);
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  void _filtrar(String value) {
    List<Lancamento> res = [];
    if (value.isEmpty) {
      _results_filtred = _results;
    } else {
      res = _results
          .where((item) =>
              item.tipo!.toLowerCase().contains(value.toLowerCase()) ||
              item.data!.toLowerCase().contains(value.toLowerCase()) ||
              item.descricao!.toLowerCase().contains(value.toLowerCase()) ||
              item.valor!.toString().contains(value))
          .toList();
      setState(() {
        _results_filtred = res;
        print(_results_filtred);
      });
    }
  }
}
