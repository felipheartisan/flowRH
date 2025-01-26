
import 'package:flow_rh/domain/controllers/funcionario_controller.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/functionary/FormFunctionaryScreen.dart';
import 'package:flow_rh/view/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchFunctionaryScreen extends StatefulWidget {
  static const String routName = "search.functionary";

  const SearchFunctionaryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFunctionaryScreenState();
}

class _SearchFunctionaryScreenState extends State<SearchFunctionaryScreen> {
  final FuncionarioController funcionarioController =
      FuncionarioController(FuncionarioRepository(client: HttpClient()));

  List<Funcionario> _results = [];
  List<Funcionario> _results_filtred = [];






  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    // List<Funcionario> res = await funcionarioRepository.findAll();

    // all_avaliacoes = await avaliacoesRepository.findAll();
    // all_funcBene = await funcbeneRepository.findAll();

    // setState(() {
    //   _results = res;
    //   _results_filtred = res;
    // });

    final response = await funcionarioController.listarFuncionarios();
    List<Funcionario> res = response[0].dados ?? [];
    setState(() {
      _results = res;
      _results_filtred = res;
    });
  }

  Future<void> _buscarTodos() async {
    //Atualiza a lista de pesquisa novamente
    final response = await funcionarioController.listarFuncionarios();
    List<Funcionario> res = response[0].dados ?? [];
    print(res);
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
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            print(_results_filtred[index]);
            Funcionario funcionario = _results_filtred[index];
            print(funcionario);

            final response =
                await funcionarioController.deletarFuncionario(funcionario.id!);
            List<Funcionario> res = response[0].dados ?? [];
            setState(() {
              _results = res;
            });
            await _buscarTodos();
          },
        ),
        onTap: () async {
          Funcionario funcionario = _results_filtred[index];
          print(funcionario);

          await Navigator.of(context).pushNamed(FormFunctionaryScreen.routName,
              arguments: funcionario);

          // final response = await funcionarioController.listarFuncionarios();
          // List<Funcionario> res = response[0].dados ?? [];
          // setState(() {
          //   _results = res;
          // });
          // await _buscarTodos();
        },
      ),
    );
  }

  void _filtrar(String value) {
    List<Funcionario> res = [];
    if (value.isEmpty) {
      _results_filtred = _results;
    } else {
      res = _results
          .where(
              (item) => item.nome!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _results_filtred = res;
      });
    }
  }
}

extension on List<ResponseModel<Funcionario>> {
  get dados => null;
}
