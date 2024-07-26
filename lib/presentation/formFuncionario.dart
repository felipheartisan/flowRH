import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flutter/material.dart';

class CadastroFuncionarioScreen extends StatefulWidget {
  @override
  _CadastroFuncionarioScreenState createState() =>
      _CadastroFuncionarioScreenState();
}

class _CadastroFuncionarioScreenState extends State<CadastroFuncionarioScreen> {
  // Controladores para os campos de texto
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _rgController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _ruaController = TextEditingController();
  TextEditingController _numeroCasaController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              // Campo de texto para CPF
              TextField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),

              // Campo de texto para RG
              TextField(
                controller: _rgController,
                decoration: InputDecoration(labelText: 'RG'),
              ),
              SizedBox(height: 20.0),

              // Campo de texto para telefone
              TextField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
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

              // Campo de texto para email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
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
                  SizedBox(height: 20), // Espaço de 20 pixels entre os botões
                  // Botão para Colaboradores Cadastrados
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para exibir colaboradores cadastrados aqui
                    },
                    child: Text('Colaboradores Cadastrados'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Função para salvar o funcionário
  void _salvarFuncionario() {
    DatabaseProvider databaseProvider = DatabaseProvider();
    FuncionarioRepository funcionarioRepository = FuncionarioRepository(databaseProvider);

    Funcionario funcionario = Funcionario();
    funcionario.nome = 'Erard';
    funcionario.data_nascimento = '10/11/2002';
    funcionario.salario = '20000';
    funcionario.cargo = 'secretario';
    funcionario.departamento = 'secretaria';
    funcionario.cpf = _cpfController.text;
    funcionario.rg = _rgController.text;
    funcionario.telefone = _telefoneController.text;
    funcionario.rua = _ruaController.text;
    funcionario.numero_casa = _numeroCasaController.text;
    funcionario.bairro = _bairroController.text;
    funcionario.cidade = _cidadeController.text;
    funcionario.email =  _emailController.text;
    

    // Aqui você pode implementar a lógica para salvar os dados
    // Pode ser chamada uma função para enviar os dados para um banco de dados, por exemplo
    
                
    // Exemplo de uso: exibir um snackbar para confirmar a ação
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Funcionário salvo: $funcionario'),
      ),
    );

    // Limpar os campos após salvar
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
