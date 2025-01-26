import 'dart:io';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/avaliacao_controller.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/view/avaliation/FormAvaliationScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flow_rh/domain/http/http_client.dart';

class SearchAvaliationScreen extends StatefulWidget {
  static const String routName = "avaliation";

  const SearchAvaliationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchAvaliationScreenState();
}

class _SearchAvaliationScreenState extends State<SearchAvaliationScreen> {
  final AvaliacaoController avaliacaoController =
      AvaliacaoController(AvaliacaoRepository(client: HttpClient()));

  List<Avaliacao> _results = [];
  List<Avaliacao> _results_filtred = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    // await databaseProvider.open();
    // avaliacoesRepository = AvaliacoesRepository(databaseProvider);
    // List<Avaliacao> res = await avaliacoesRepository.findAll();
    // setState(() {
    //   _results = res;
    //   _results_filtred = res;
    // });

    final response = await avaliacaoController.listarAvaliacoes();
    List<Avaliacao> res = response[0].dados ?? [];
    print(res);
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
        title: Text(
            'Funcionário: ${_results_filtred[index].NomeFuncionario}' '\n' +
                'Nota: ${_results_filtred[index].nota}' +
                '\n' +
                'Mês: ${_results_filtred[index].mesReferencia}' +
                '\n' +
                'Ano: ${_results_filtred[index].anoReferencia}'),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            Avaliacao avaliacao = _results_filtred[index];
            print(avaliacao);

            final response =
                await avaliacaoController.deletarAvaliacao(avaliacao.id!);

            List<Avaliacao> res = response[0].dados ?? [];
            print(res);
            setState(() {
              _results = res;
              _results_filtred = res;
            });
            await _buscarTodos();
          },
        ),
        onTap: () async {
          Avaliacao avaliacao = _results_filtred[index];
          print(avaliacao);
          await Navigator.of(context)
              .pushNamed(FormAvaliationScreen.routName, arguments: avaliacao);
          final response = await avaliacaoController.listarAvaliacoes();
          List<Avaliacao> res = response[0].dados ?? [];
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
    final response = await avaliacaoController.listarAvaliacoes();
    List<Avaliacao> res = response[0].dados ?? [];
    print(res);
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  void _filtrar(String value) {
    List<Avaliacao> res = [];
    if (value.isEmpty) {
      _results_filtred = _results;
    } else {
      res = _results
          .where((item) =>
              item.NomeFuncionario!
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              item.mesReferencia!.toLowerCase().contains(value.toLowerCase()) ||
              item.anoReferencia!.toLowerCase().contains(value.toLowerCase()) ||
              item.nota!.toString().contains(value.toLowerCase()) ||
              item.cursosFeitos!.toLowerCase().contains(value.toLowerCase()) ||
              item.cursosInteresse!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _results_filtred = res;
      });
    }
  }
}
