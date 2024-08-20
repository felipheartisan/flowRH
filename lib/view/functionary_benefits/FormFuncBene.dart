import 'package:flow_rh/data/database_provider.dart';
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

  @override
  _FormFuncBeneScreenState createState() => _FormFuncBeneScreenState();
}

class _FormFuncBeneScreenState extends State<FormFuncBeneScreen> {
   List<BeneficiosFuncionarios> _results = [];
   List<Funcionario> _funcionarios = [];
   List<Beneficio> _beneficios = [];
  

  DatabaseProvider databaseProvider = DatabaseProvider();
  late BeneficiosFuncionariosRepository beneficiosFuncRepository;
  late FuncionarioRepository funcionarioRepository;
  late BeneficiosRepository beneficiosRepository;

  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    beneficiosFuncRepository = BeneficiosFuncionariosRepository(databaseProvider);
    funcionarioRepository = FuncionarioRepository(databaseProvider);
    beneficiosRepository = BeneficiosRepository(databaseProvider);
    
    _results = await beneficiosFuncRepository.findAll();
    List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();

    

    _funcionarios = await funcionarioRepository.findAll();
    List<Funcionario> fun = await funcionarioRepository.findAll();


    _beneficios = await beneficiosRepository.findAll();
    List<Beneficio> ben = await beneficiosRepository.findAll();
   
    setState(() {
      _results = res;
      _funcionarios = fun;
      _beneficios = ben;
    });


  }


  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  
  Beneficio? _selectedBeneficio;
  Funcionario? _selectedFuncionario;

   TextEditingController _funcionarioController = TextEditingController();
   TextEditingController _beneficioController = TextEditingController();

   final BeneficiosFuncionarios _beneficio_funcionario = BeneficiosFuncionarios();

  @override

   Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
      BeneficiosFuncionarios _beneficio_funcionario = ModalRoute.of(context)!.settings.arguments as BeneficiosFuncionarios;

      _funcionarioController.text = _beneficio_funcionario.nome_funcionario!;
      _beneficioController.text = _beneficio_funcionario.descricao_beneficio!; 

    }
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Benefícios & Funcionários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
                    controller: _funcionarioController,
                    decoration: InputDecoration(labelText: 'Funcionário'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),
            
            TextField(
                    controller: _beneficioController,
                    decoration: InputDecoration(labelText: 'Beneficio'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.0),


      

            DropdownButton<Beneficio>(
              hint: Text('Selecione um Benefício'),
              value: _selectedBeneficio,
               
              onChanged: (Beneficio? beneficio) {
                setState(() {
                  _selectedBeneficio = beneficio;
                });
              },
              items: _beneficios.map<DropdownMenuItem<Beneficio>>((Beneficio beneficio) {
                return DropdownMenuItem<Beneficio>(
                  value: beneficio,
                  child: Text(beneficio.descricao!),

                );
              }).toList(),
            ),
            SizedBox(height: 16),
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
            ElevatedButton(
              onPressed: () async{
                _salvar();
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
            // Expanded(
            //   child: FutureBuilder<List<BeneficiosFuncionarios>>(
            //     future: _dbHelper.beneficiosFuncionarios(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Center(child: Text('Erro: ${snapshot.error}'));
            //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //         return Center(child: Text('Nenhum registro encontrado.'));
            //       } else {
            //         final data = snapshot.data!;
            //         return ListView.builder(
            //           itemCount: data.length,
            //           itemBuilder: (context, index) {
            //             final item = data[index];
            //             return ListTile(
            //               title: Text('Benefício: ${item.idBeneficios.nome}, Funcionário: ${item.idFuncionarios.nome}'),
            //             );
            //           },
            //         );
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

void _salvar() async {
    if (_selectedBeneficio != null && _selectedFuncionario != null) {
        print('chamou');

        _funcionarioController.text = _selectedFuncionario!.nome!;
        _beneficioController.text = _selectedBeneficio!.descricao!;

         _beneficio_funcionario.idBeneficios = _selectedBeneficio?.idBeneficios;
         _beneficio_funcionario.idFuncionarios = _selectedFuncionario?.idFuncionarios;

         _beneficio_funcionario.nome_funcionario = _funcionarioController.text;
         _beneficio_funcionario.descricao_beneficio = _beneficioController.text; 


        if(_beneficio_funcionario.id_beneficios_funcionarios == null){
          await beneficiosFuncRepository.insert(_beneficio_funcionario);
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Beneficio & Funcionario vinculados'),
          ),);
           Navigator.pushNamed(context, HomeScreen.routName);
           List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();
                               setState(() {
                                 _results = res;
                               });
        }else{
          await beneficiosFuncRepository.update(_beneficio_funcionario);
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Beneficio & Funcionario atualizados'),
          ),);
           Navigator.pushNamed(context, HomeScreen.routName);
           List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();
                               setState(() {
                                 _results = res;
                               });
        }
      
        
      
        
    }
  }
}

