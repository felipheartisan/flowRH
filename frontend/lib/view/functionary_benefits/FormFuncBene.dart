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

  const FormFuncBeneScreen({super.key});

  @override
  _FormFuncBeneScreenState createState() => _FormFuncBeneScreenState();
}

class _FormFuncBeneScreenState extends State<FormFuncBeneScreen> {
   List<Funcionario> _funcionarios = [];
   List<Beneficio> _beneficios = [];
  

  DatabaseProvider databaseProvider = DatabaseProvider();
  late BeneficiosFuncionariosRepository beneficiosFuncRepository;
  late FuncionarioRepository funcionarioRepository;
  late BeneficiosRepository beneficiosRepository;

  @override
  void initState(){
    super.initState();
    // initDatabase();
  }

  // void initDatabase() async {
  //   await databaseProvider.open();
  //   beneficiosFuncRepository = BeneficiosFuncionariosRepository(databaseProvider);
  //   funcionarioRepository = FuncionarioRepository(databaseProvider);
  //   beneficiosRepository = BeneficiosRepository(databaseProvider);
    
  //   // ignore: unused_local_variable
  //   List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();

    

  //   _funcionarios = await funcionarioRepository.findAll();
  //   List<Funcionario> fun = await funcionarioRepository.findAll();


  //   _beneficios = await beneficiosRepository.findAll();
  //   List<Beneficio> ben = await beneficiosRepository.findAll();
   
  //   setState(() {
  //     _funcionarios = fun;
  //     _beneficios = ben;
  //   });


  // }

  
  Beneficio? _selectedBeneficio;
  Funcionario? _selectedFuncionario;

   final TextEditingController _funcionarioController = TextEditingController();
   final TextEditingController _beneficioController = TextEditingController();

   BeneficiosFuncionarios _beneficio_funcionario = BeneficiosFuncionarios();

  @override

   Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
    _beneficio_funcionario = ModalRoute.of(context)!.settings.arguments as BeneficiosFuncionarios;

      _funcionarioController.text = _beneficio_funcionario.nome_funcionario!;
      _beneficioController.text = _beneficio_funcionario.descricao_beneficio!; 

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
              items: _beneficios.map<DropdownMenuItem<Beneficio>>((Beneficio beneficio) {
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
              items: _funcionarios.map<DropdownMenuItem<Funcionario>>((Funcionario funcionario) {
                return DropdownMenuItem<Funcionario>(
                  value: funcionario,
                  child: Text(funcionario.nome!),

                );
              }).toList(),
              
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                _salvar();
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 16),
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
            //               title: Text('Benefício: ${item.id.nome}, Funcionário: ${item.idFuncionarios.nome}'),
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

        print('chamou');

        _funcionarioController.text = _selectedFuncionario!.nome!;
        _beneficioController.text = _selectedBeneficio!.descricao!;

         _beneficio_funcionario.idBeneficios = _selectedBeneficio?.id;
         _beneficio_funcionario.idFuncionarios = _selectedFuncionario?.id;

         _beneficio_funcionario.nome_funcionario = _funcionarioController.text;
         _beneficio_funcionario.descricao_beneficio = _beneficioController.text; 


        if(_beneficio_funcionario.id_beneficios_funcionarios == null){
          await beneficiosFuncRepository.insert(_beneficio_funcionario);
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Beneficio & Funcionario vinculados'),
          ),);
           Navigator.pushNamed(context, HomeScreen.routName);
           // ignore: unused_local_variable
           List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();
                               setState(() {
                               });
        }else{
          await beneficiosFuncRepository.update(_beneficio_funcionario);
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Beneficio & Funcionario atualizados'),
          ),);
           Navigator.pushNamed(context, HomeScreen.routName);
           // ignore: unused_local_variable
           List<BeneficiosFuncionarios> res = await beneficiosFuncRepository.findAll();
                               setState(() {
                               });
        }
      
        
      
        

  }
}

