import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/beneficio_controller.dart';
import 'package:flow_rh/domain/controllers/beneficio_funcionario_controller.dart';
import 'package:flow_rh/domain/controllers/funcionario_controller.dart';
import 'package:flow_rh/domain/dto/beneficio_funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/beneficios_funcionarios_repository.dart';
import 'package:flow_rh/domain/repositories/beneficios_repository.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/home_screen.dart';
import 'package:flutter/material.dart';

class FormFuncBeneScreen extends StatefulWidget {
  static const String routName = "form.funcbenefit";

  const FormFuncBeneScreen({super.key});

  @override
  _FormFuncBeneScreenState createState() => _FormFuncBeneScreenState();
}

class _FormFuncBeneScreenState extends State<FormFuncBeneScreen> {
  List<Funcionario> _funcionarios = [];
  List<Beneficio> _beneficios = [];

  final BeneficioController beneficioController =
      BeneficioController(BeneficiosRepository(client: HttpClient()));

  final FuncionarioController funcionarioController =
      FuncionarioController(FuncionarioRepository(client: HttpClient()));

  final BeneficioFuncionarioController beneficiosFuncController =
      BeneficioFuncionarioController(
          BeneficiosFuncionariosRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    final response = await beneficioController.ListarBeneficios();
    List<Beneficio> res = response[0].dados ?? [];

    final responseFuncionario =
        await funcionarioController.listarFuncionarios();
    List<Funcionario> resFuncionario = responseFuncionario[0].dados ?? [];
    print(res);
    setState(() {
      _beneficios = res;
      _funcionarios = resFuncionario;
    });
  }

  Beneficio? _selectedBeneficio;
  Funcionario? _selectedFuncionario;

  final TextEditingController _funcionarioController = TextEditingController();
  final TextEditingController _beneficioController = TextEditingController();

  BeneficiosFuncionarios _beneficio_funcionario = BeneficiosFuncionarios();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      _beneficio_funcionario =
          ModalRoute.of(context)!.settings.arguments as BeneficiosFuncionarios;

      _funcionarioController.text = _beneficio_funcionario.funcionario!.nome!;
      _beneficioController.text = _beneficio_funcionario.beneficio!.descricao!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Benefícios & Funcionários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _funcionarioController,
              decoration: const InputDecoration(labelText: 'Funcionário'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _beneficioController,
              decoration: const InputDecoration(labelText: 'Beneficio'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            DropdownButton<Beneficio>(
              hint: const Text('Selecione um Benefício'),
              value: _selectedBeneficio,
              onChanged: (Beneficio? beneficio) {
                setState(() {
                  _selectedBeneficio = beneficio;
                });
              },
              items: _beneficios
                  .map<DropdownMenuItem<Beneficio>>((Beneficio beneficio) {
                return DropdownMenuItem<Beneficio>(
                  value: beneficio,
                  child: Text(beneficio.descricao!),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
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
            ElevatedButton(
              onPressed: () async {
                _salvar();
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
    if (_selectedFuncionario == null || _selectedBeneficio == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um Funcionario e um Beneficio'),
        ),
      );
      return;
    }

    var result;

    print('chamou');

    _funcionarioController.text = _selectedFuncionario!.nome!;
    _beneficioController.text = _selectedBeneficio!.descricao!;

    _beneficio_funcionario.beneficio = _selectedBeneficio;
    _beneficio_funcionario.funcionario = _selectedFuncionario;

      var beneficioFuncionarioCriacaoDto = BeneficioFuncionarioCriacaoDto(
          funcionarioId: _beneficio_funcionario.funcionario!.id,
          beneficioId: _beneficio_funcionario.beneficio!.id);

      result = await beneficiosFuncController
          .addBeneficiosFuncionarios(beneficioFuncionarioCriacaoDto);
    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result[0].mensagem),
      ),
    );

    final response = await beneficioController.ListarBeneficios();
    List<Beneficio> res = response[0].dados ?? [];

    final responseFuncionario =
        await funcionarioController.listarFuncionarios();
    List<Funcionario> resFuncionario = responseFuncionario[0].dados ?? [];
    print(res);
    setState(() {
      _beneficios = res;
      _funcionarios = resFuncionario;
    });

    // Limpar os campos após salvar
    _funcionarioController.clear();
    _beneficioController.clear();
  }
}
