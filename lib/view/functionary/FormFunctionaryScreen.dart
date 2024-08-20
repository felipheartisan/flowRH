

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';


import 'package:flutter/material.dart';

class FormFunctionaryScreen extends StatefulWidget {
  static const String routName = "form.functionary";
  @override
  _FormFunctionaryScreenState createState() =>
      _FormFunctionaryScreenState();
}

class _FormFunctionaryScreenState extends State<FormFunctionaryScreen> {
      // ignore: unused_field
      List<Funcionario> _results = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late FuncionarioRepository funcionarioRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    funcionarioRepository = FuncionarioRepository(databaseProvider);
    _results = await funcionarioRepository.findAll();
    List<Funcionario> res = await funcionarioRepository.findAll();
    setState(() {
      _results = res;
    });
  }



  // Controladores para os campos de texto
  TextEditingController _nomeController         = TextEditingController();
  TextEditingController _datanascController     = TextEditingController();
  TextEditingController _salarioController      = TextEditingController();
  TextEditingController _cargoController        = TextEditingController();
  TextEditingController _departamentoController = TextEditingController();
  TextEditingController _cpfController          = TextEditingController();
  TextEditingController _rgController           = TextEditingController();
  TextEditingController _telefoneController     = TextEditingController();
  TextEditingController _ruaController          = TextEditingController();
  TextEditingController _numeroCasaController   = TextEditingController();
  TextEditingController _bairroController       = TextEditingController();
  TextEditingController _cidadeController       = TextEditingController();
  TextEditingController _emailController        = TextEditingController();

  Funcionario _funcionario = Funcionario();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
      _funcionario = ModalRoute.of(context)!.settings.arguments as Funcionario;
      _nomeController.text = _funcionario.nome!;
      _datanascController.text = _funcionario.data_nascimento!;
      _salarioController.text = _funcionario.salario!;
      _cargoController.text = _funcionario.cargo!;
      _departamentoController.text = _funcionario.departamento!;
      _cpfController.text = _funcionario.cpf!;
      _rgController.text = _funcionario.rg!;
      _telefoneController.text = _funcionario.telefone!;
      _ruaController.text = _funcionario.rua!;
      _numeroCasaController.text = _funcionario.numero_casa!;
      _bairroController.text = _funcionario.bairro!;
      _cidadeController.text = _funcionario.cidade!;
      _emailController.text = _funcionario.email!;
    }


     return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'NOME COMPLETO'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              TextField(
                controller: _datanascController,
                decoration: InputDecoration(labelText: 'DATA DE NASCIMENTO'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              TextField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              TextField(
                controller: _salarioController,
                decoration: InputDecoration(labelText: 'Salário'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              TextField(
                controller: _cargoController,
                decoration: InputDecoration(labelText: 'Cargo'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              TextField(
                controller: _departamentoController,
                decoration: InputDecoration(labelText: 'Departamento'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              // Campo de texto para RG
              TextField(
                controller: _rgController,
                decoration: InputDecoration(labelText: 'RG'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),

              // Campo de texto para telefone
              TextField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.0),
              // Campo de texto para email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),

              // Campos lado a lado: Rua e Número da Casa
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _ruaController,
                      decoration: InputDecoration(labelText: 'Rua'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _numeroCasaController,
                      decoration: InputDecoration(labelText: 'Número'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              // Campos lado a lado: Bairro e Cidade
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _bairroController,
                      decoration: InputDecoration(labelText: 'Bairro'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _cidadeController,
                      decoration: InputDecoration(labelText: 'Cidade'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Botão para salvar
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para salvar os dados aqui
                      _salvarFuncionario();
                    },
                    child: Text('Salvar'),
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
  void _salvarFuncionario() async{
    _funcionario.nome = _nomeController.text;
    _funcionario.data_nascimento = _datanascController.text;
    _funcionario.salario = _salarioController.text;
    _funcionario.cargo = _cargoController.text;
    _funcionario.departamento = _departamentoController.text;
    _funcionario.cpf = _cpfController.text;
    _funcionario.rg = _rgController.text;
    _funcionario.telefone = _telefoneController.text;
    _funcionario.rua = _ruaController.text;
    _funcionario.numero_casa = _numeroCasaController.text;
    _funcionario.bairro = _bairroController.text;
    _funcionario.cidade = _cidadeController.text;
    _funcionario.email =  _emailController.text;

    if (_funcionario.idFuncionarios == null)
    {
      await funcionarioRepository.insert(_funcionario);
    }
    else
    {
      await funcionarioRepository.update(_funcionario);
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Funcionário salvo'),
      ),
    );

    List<Funcionario> res = await funcionarioRepository.findAll();
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
