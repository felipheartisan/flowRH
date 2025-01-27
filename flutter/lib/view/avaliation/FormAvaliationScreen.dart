import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/avaliacao_controller.dart';
import 'package:flow_rh/domain/controllers/funcionario_controller.dart';
import 'package:flow_rh/domain/dto/avaliacao_criacao_dto.dart';
import 'package:flow_rh/domain/dto/avaliacao_edicao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/avaliation/SearchAvaliationScreen.dart';
import 'package:flow_rh/view/home_screen.dart';
import 'package:flutter/material.dart';

class FormAvaliationScreen extends StatefulWidget {
  static const String routName = "form.avaliation";

  const FormAvaliationScreen({super.key});

  @override
  _FormAvaliationScreenState createState() => _FormAvaliationScreenState();
}

class _FormAvaliationScreenState extends State<FormAvaliationScreen> {
  final AvaliacaoController avaliacaoController =
      AvaliacaoController(AvaliacaoRepository(client: HttpClient()));

  final FuncionarioController funcionarioController =
      FuncionarioController(FuncionarioRepository(client: HttpClient()));
  // ignore: unused_field
  List<Avaliacao> _results = [];
  List<Funcionario> _funcionarios = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    // avaliacaoRepository = AvaliacoesRepository(databaseProvider);
    // funcionarioRepository = FuncionarioRepository(databaseProvider);

    // _results = await avaliacaoRepository.findAll();
    // List<Avaliacao> res = await avaliacaoRepository.findAll();

    // _funcionarios = await funcionarioRepository.findAll();
    // List<Funcionario> fun = await funcionarioRepository.findAll();

    final response = await avaliacaoController.listarAvaliacoes();
    List<Avaliacao> res = response[0].dados ?? [];

    final responseFuncionario =
        await funcionarioController.listarFuncionarios();
    List<Funcionario> resFuncionario = responseFuncionario[0].dados ?? [];
    print(res);
    setState(() {
      _results = res;
      _funcionarios = resFuncionario;
    });
  }

  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _cursos_feitosController =
      TextEditingController();
  final TextEditingController _cursos_interesseController =
      TextEditingController();
  final TextEditingController _atividadesController = TextEditingController();
  final TextEditingController _mesController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();

  Funcionario? _selectedFuncionario;

  // ignore: non_constant_identifier_names
  Avaliacao _avaliacao = Avaliacao();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      _avaliacao = ModalRoute.of(context)!.settings.arguments as Avaliacao;
      _notaController.text = _avaliacao.nota!;
      _cursos_feitosController.text = _avaliacao.cursosFeitos!;
      _cursos_interesseController.text = _avaliacao.cursosInteresse!;
      _atividadesController.text = _avaliacao.atividades!;
      _mesController.text = _avaliacao.mesReferencia!;
      _anoController.text = _avaliacao.anoReferencia!;
      _selectedFuncionario = _avaliacao.funcionario;
      _selectedFuncionario?.nome = _avaliacao.NomeFuncionario;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações de funcionários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Funcionario>(
              hint: const Text('Selecione um Funcionário'),
              value: _selectedFuncionario,
              onChanged: (Funcionario? newFuncionario) {
                setState(() {
                  _selectedFuncionario = newFuncionario;
                });
              },
              items: _funcionarios.map<DropdownMenuItem<Funcionario>>(
                  (Funcionario funcionario) {
                return DropdownMenuItem<Funcionario>(
                  value: funcionario,
                  child: Text(funcionario.nome!),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notaController,
              decoration: const InputDecoration(labelText: 'Nota'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _cursos_feitosController,
              decoration: const InputDecoration(labelText: 'Cursos feitos'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _cursos_interesseController,
              decoration:
                  const InputDecoration(labelText: 'Cursos de interesse'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _atividadesController,
              decoration:
                  const InputDecoration(labelText: 'Atividades realizadas'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _mesController,
              decoration: const InputDecoration(labelText: 'Mês de referência'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _anoController,
              decoration: const InputDecoration(labelText: 'Ano de referência'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                _salvar();
                final response = await avaliacaoController.listarAvaliacoes();
                List<Avaliacao> res = response[0].dados ?? [];

                final responseFuncionario =
                    await funcionarioController.listarFuncionarios();

                List<Funcionario> resFuncionario =
                    responseFuncionario[0].dados ?? [];

                setState(() {
                  _results = res;
                  _funcionarios = resFuncionario;
                });
                await Navigator.of(context)
                    .pushNamed(SearchAvaliationScreen.routName);
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _salvar() async {
    var result;

    if (_selectedFuncionario != null) {
      _avaliacao.funcionario = _selectedFuncionario!;
      _avaliacao.anoReferencia = _anoController.text;
      _avaliacao.mesReferencia = _mesController.text;
      _avaliacao.nota = _notaController.text;
      _avaliacao.cursosFeitos = _cursos_feitosController.text;
      _avaliacao.cursosInteresse = _cursos_interesseController.text;
      _avaliacao.atividades = _atividadesController.text;

      if (_avaliacao.id == null) {
        var avaliacaoCriacaoDto = AvaliacaoCriacaoDto(
            nota: _avaliacao.nota,
            cursosFeitos: _avaliacao.cursosFeitos,
            cursosFazer: _avaliacao.cursosInteresse,
            atividades: _avaliacao.atividades,
            mesReferencia: _avaliacao.mesReferencia,
            anoReferencia: _avaliacao.anoReferencia,
            idFuncionario: _avaliacao.funcionario?.id);

        result = await avaliacaoController.criarAvaliacao(avaliacaoCriacaoDto);
      } else {
        var avaliacaoEdicaoDto = AvaliacaoEdicaoDto(
            id: _avaliacao.id,
            nota: _avaliacao.nota,
            cursosFeitos: _avaliacao.cursosFeitos,
            cursosFazer: _avaliacao.cursosInteresse,
            atividades: _avaliacao.atividades,
            mesReferencia: _avaliacao.mesReferencia,
            anoReferencia: _avaliacao.anoReferencia,
            idFuncionario: _avaliacao.funcionario?.id);

        result =
            await avaliacaoController.atualizarAvaliacao(avaliacaoEdicaoDto);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result[0].mensagem),
        ),
      );

      final response = await avaliacaoController.listarAvaliacoes();

      List<Avaliacao> res = response[0].dados ?? [];

      final responseFuncionario =
          await funcionarioController.listarFuncionarios();
      List<Funcionario> resFuncionario = responseFuncionario[0].dados ?? [];

      setState(() {
        _results = res;
        _funcionarios = resFuncionario;
      });

      // Limpar os campos após salvar
      _notaController.clear();
      _cursos_feitosController.clear();
      _cursos_interesseController.clear();
      _atividadesController.clear();
      _mesController.clear();
      _anoController.clear();
    }
  }
}
