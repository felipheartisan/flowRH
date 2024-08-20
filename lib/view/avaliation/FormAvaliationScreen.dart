import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/view/home_screen.dart';
import 'package:flutter/material.dart';

class FormAvaliationScreen extends StatefulWidget {
  static const String routName = "form.avaliation";

  @override
  _FormAvaliationScreenState createState() => _FormAvaliationScreenState();
}

class _FormAvaliationScreenState extends State<FormAvaliationScreen> {
   // ignore: unused_field
   List<Avaliacao> _results = [];
   List<Funcionario> _funcionarios = [];



  DatabaseProvider databaseProvider = DatabaseProvider();
  late AvaliacoesRepository avaliacaoRepository;
  late FuncionarioRepository funcionarioRepository;

  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    avaliacaoRepository = AvaliacoesRepository(databaseProvider);
    funcionarioRepository = FuncionarioRepository(databaseProvider);

    
    _results = await avaliacaoRepository.findAll();
    List<Avaliacao> res = await avaliacaoRepository.findAll();

    

    _funcionarios = await funcionarioRepository.findAll();
    List<Funcionario> fun = await funcionarioRepository.findAll();

   
    setState(() {
      _results = res;
      _funcionarios = fun;

    });


  }



  TextEditingController _notaController = TextEditingController();
  TextEditingController _cursos_feitosController = TextEditingController();
  TextEditingController _cursos_interesseController = TextEditingController();
  TextEditingController _atividadesController = TextEditingController();
  TextEditingController _mesController = TextEditingController();
  TextEditingController _anoController = TextEditingController();

  Funcionario? _selectedFuncionario;

  // ignore: non_constant_identifier_names
  Avaliacao _avaliacao = Avaliacao();


  @override

   Widget build(BuildContext context) {

    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
      _avaliacao = ModalRoute.of(context)!.settings.arguments as Avaliacao;
      _notaController.text = _avaliacao.nota!;
      _cursos_feitosController.text = _avaliacao.cursosFeitos!;
      _cursos_interesseController.text = _avaliacao.cursosInteresse!;
      _atividadesController.text = _avaliacao.atividades!;
      _mesController.text = _avaliacao.mesReferencia!;
      _anoController.text = _avaliacao.anoReferencia!;
      _selectedFuncionario?.idFuncionarios = _avaliacao.IdFuncionarios!;
      _selectedFuncionario?.nome = _avaliacao.NomeFuncionario;      
    }
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações de funcionários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [


            DropdownButton<Funcionario>(
              hint: Text('Selecione um Funcionário'),
              value: _selectedFuncionario,
              onChanged: (Funcionario? newFuncionario) {
                setState(() {
                  _selectedFuncionario = newFuncionario;
                });
              },
              items: _funcionarios.map<DropdownMenuItem<Funcionario>>((Funcionario funcionario) {
                return DropdownMenuItem<Funcionario>(
                  value: funcionario,
                  child: Text(funcionario.nome!),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            TextFormField(
                    controller: _notaController,
                    decoration: InputDecoration(labelText: 'Nota'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),

            TextFormField(
                    controller: _cursos_feitosController,
                    decoration: InputDecoration(labelText: 'Cursos feitos'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),

            TextFormField(
                    controller: _cursos_interesseController,
                    decoration: InputDecoration(labelText: 'Cursos de interesse'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),

            TextFormField(
                    controller: _atividadesController,
                    decoration: InputDecoration(labelText: 'Atividades realizadas'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),
            
            
            TextFormField(
                    controller: _mesController,
                    decoration: InputDecoration(labelText: 'Mês de referência'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),
            
            TextFormField(
                    controller: _anoController,
                    decoration: InputDecoration(labelText: 'Ano de referência'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),




            ElevatedButton(
              onPressed: () async{
                _salvar();
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
           
          ],
        ),
      ),
    );
  }

  
    void _salvar() async {
    if ( _selectedFuncionario != null) {
      
        
        _avaliacao.IdFuncionarios = _selectedFuncionario?.idFuncionarios;
        _avaliacao.anoReferencia = _anoController.text;
        _avaliacao.mesReferencia = _mesController.text;
        _avaliacao.nota = _notaController.text;
        _avaliacao.cursosFeitos = _cursos_feitosController.text;
        _avaliacao.cursosInteresse = _cursos_interesseController.text;
        _avaliacao.atividades = _atividadesController.text;
      

      if (_avaliacao.idAvaliacoes == null){
        await avaliacaoRepository.insert(_avaliacao);
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Avaliação salva'),
          ),);

        Navigator.pushNamed(context, HomeScreen.routName); 

      }else{
        await avaliacaoRepository.update(_avaliacao);
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Avaliação atualizada'),
          ),);

        Navigator.pushNamed(context, HomeScreen.routName); 
      }
        
        List<Avaliacao> res = await avaliacaoRepository.findAll();
                               setState(() {
                                 _results = res;
                               });
    }
  }

}

