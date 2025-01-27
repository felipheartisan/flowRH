import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/funcionario_controller.dart';
import 'package:flow_rh/domain/dto/funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/functionary/SearchFunctionaryScreen.dart';

import 'package:flutter/material.dart';

import '../../domain/http/http_client.dart';

class FormFunctionaryScreen extends StatefulWidget {
  static const String routName = "form.functionary";

  const FormFunctionaryScreen({super.key});
  @override
  _FormFunctionaryScreenState createState() => _FormFunctionaryScreenState();
}

class _FormFunctionaryScreenState extends State<FormFunctionaryScreen> {
  // ignore: unused_field
  List<Funcionario> _results = [];

  final FuncionarioController funcionarioController =
      FuncionarioController(FuncionarioRepository(client: HttpClient()));

  DatabaseProvider databaseProvider = DatabaseProvider();
  late FuncionarioRepository funcionarioRepository;

  @override
  void initState() {
    super.initState();
  }

  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _datanascController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _departamentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroCasaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Funcionario _funcionario = Funcionario();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      _funcionario = ModalRoute.of(context)!.settings.arguments as Funcionario;
      _nomeController.text = _funcionario.nome!;
      _datanascController.text = _funcionario.dataNascimento!;
      _salarioController.text = _funcionario.salario!;
      _cargoController.text = _funcionario.cargo!;
      _departamentoController.text = _funcionario.departamento!;
      _cpfController.text = _funcionario.cpf!;
      _rgController.text = _funcionario.rg!;
      _telefoneController.text = _funcionario.telefone!;
      _ruaController.text = _funcionario.rua!;
      _numeroCasaController.text = _funcionario.numeroCasa!;
      _bairroController.text = _funcionario.bairro!;
      _cidadeController.text = _funcionario.cidade!;
      _emailController.text = _funcionario.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Funcionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'NOME COMPLETO'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _datanascController,
                decoration:
                    const InputDecoration(labelText: 'DATA DE NASCIMENTO'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _salarioController,
                decoration: const InputDecoration(labelText: 'Salário'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _cargoController,
                decoration: const InputDecoration(labelText: 'Cargo'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _departamentoController,
                decoration: const InputDecoration(labelText: 'Departamento'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto para RG
              TextField(
                controller: _rgController,
                decoration: const InputDecoration(labelText: 'RG'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto para telefone
              TextField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20.0),
              // Campo de texto para email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),

              // Campos lado a lado: Rua e Número da Casa
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _ruaController,
                      decoration: const InputDecoration(labelText: 'Rua'),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _numeroCasaController,
                      decoration: const InputDecoration(labelText: 'Número'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Campos lado a lado: Bairro e Cidade
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _bairroController,
                      decoration: const InputDecoration(labelText: 'Bairro'),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _cidadeController,
                      decoration: const InputDecoration(labelText: 'Cidade'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Botão para salvar
                  ElevatedButton(
                    onPressed: () async {
                      // Lógica para salvar os dados aqui
                      _salvarFuncionario();
                      final response =
                          await funcionarioController.listarFuncionarios();

                      List<Funcionario> res = response[0].dados ?? [];

                      setState(() {
                        _results = res;
                      });
                      await Navigator.of(context)
                          .pushNamed(SearchFunctionaryScreen.routName);
                    },
                    child: const Text('Salvar'),
                  ),
                  // SizedBox(height: 20), // Espaço de 20 pixels entre os botões
                  // // Botão para Colaboradores Cadastrados
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Lógica para exibir colaboradores cadastrados aqui
                  //   },
                  //   child: Text('Colaboradores Cadastrados'),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Função para salvar o funcionário
  void _salvarFuncionario() async {
    var result;

    _funcionario.nome = _nomeController.text;
    _funcionario.dataNascimento = _datanascController.text;
    _funcionario.salario = _salarioController.text;
    _funcionario.cargo = _cargoController.text;
    _funcionario.departamento = _departamentoController.text;
    _funcionario.cpf = _cpfController.text;
    _funcionario.rg = _rgController.text;
    _funcionario.telefone = _telefoneController.text;
    _funcionario.rua = _ruaController.text;
    _funcionario.numeroCasa = _numeroCasaController.text;
    _funcionario.bairro = _bairroController.text;
    _funcionario.cidade = _cidadeController.text;
    _funcionario.email = _emailController.text;

    if (_funcionario.id == null) {
      var funcionarioCriacaoDto = FuncionarioCriacaoDto(
          nome: _funcionario.nome,
          dataNascimento: _funcionario.dataNascimento,
          salario: _funcionario.salario,
          cargo: _funcionario.cargo,
          departamento: _funcionario.departamento,
          cpf: _funcionario.cpf,
          rg: _funcionario.rg,
          telefone: _funcionario.telefone,
          rua: _funcionario.rua,
          numeroCasa: _funcionario.numeroCasa,
          bairro: _funcionario.bairro,
          cidade: _funcionario.cidade,
          email: _funcionario.email);
      //await funcionarioRepository.insert(_funcionario);
      result =
          await funcionarioController.criarFuncionario(funcionarioCriacaoDto);
    } else {
      result =
          await funcionarioController.atualizarFuncionario(_funcionario);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result[0].mensagem),
      ),
    );

    final response = await funcionarioController.listarFuncionarios();

    List<Funcionario> res = response[0].dados ?? [];

    setState(() {
      _results = res;
    });

    // Limpar os campos após salvar
    _nomeController.clear();
    _datanascController.clear();
    _salarioController.clear();
    _cargoController.clear();
    _departamentoController.clear();
    _cpfController.clear();
    _rgController.clear();
    _telefoneController.clear();
    _ruaController.clear();
    _numeroCasaController.clear();
    _bairroController.clear();
    _cidadeController.clear();
    _emailController.clear();
  }
}

extension on List<ResponseModel<Funcionario>> {
  get dados => null;
}
