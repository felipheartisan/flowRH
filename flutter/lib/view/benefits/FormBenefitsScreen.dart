import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/beneficio_controller.dart';
import 'package:flow_rh/domain/dto/beneficio_criacao_dto.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/repositories/beneficios_repository.dart';
import 'package:flutter/material.dart';

import '../../domain/http/http_client.dart';

class FormBenefitsScreen extends StatefulWidget {
  static const String routName = "form.benefit";

  const FormBenefitsScreen({super.key});

  @override
  _FormBenefitsScreenState createState() => _FormBenefitsScreenState();
}

class _FormBenefitsScreenState extends State<FormBenefitsScreen> {

  final BeneficioController beneficioController =
      BeneficioController(BeneficiosRepository(client: HttpClient()));
   // ignore: unused_field
   List<Beneficio> _results = [];

  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    // await databaseProvider.open();
    // beneficioRepository = BeneficiosRepository(databaseProvider);
    // _results = await beneficioRepository.findAll();
    // List<Beneficio> res = await beneficioRepository.findAll();
    // setState(() {
    //   _results = res;
    // });

    final response = await beneficioController.ListarBeneficios();
    List<Beneficio> res = response[0].dados ?? [];
    print(res);
    setState(() {
      _results = res;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  
  final TextEditingController _dependentesController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final List<String> _categories = ['Entrada', 'Saída'];

  Beneficio _beneficio = Beneficio();

  String? beneficio_selected;

  // Lista de benefícios
  final List<String> _benefits = [
    'Assistência Médica',
    'Vale Alimentação',
    'Vale Transporte',
    'Seguro de Vida',
    'Bonificação',
  ];

  
  @override
  Widget build(BuildContext context) {
      if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
      _beneficio = ModalRoute.of(context)!.settings.arguments as Beneficio;
      _dependentesController.text = _beneficio.dependentes!;
      _descController.text =_beneficio.descricao!;
    }



    return Scaffold(
      appBar: AppBar(
        title: const Text('Benefícios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Selecione um benefício',
                border: OutlineInputBorder(),
              ),
              value: beneficio_selected,
              items: _benefits.map((String benefit) {
                return DropdownMenuItem<String>(
                  value: benefit,
                  child: Text(benefit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  beneficio_selected = newValue!;
  
                });
              },
            ),
            const SizedBox(height: 20),
              
              Text(
                'Descrição do benefício selecionado: ${_descController.text}',
                style: const TextStyle(fontSize: 16),
              ),
               const SizedBox(height: 20),
              TextFormField(
                    controller: _dependentesController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Dependentes',
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Center(
                    child: ElevatedButton(
                      onPressed: () async{
                        _salvar();
                      }, 
                      child: const Text('Salvar'),
                    )
                      
                  )

          ],
        ),
      ),
    );
  }

  void _salvar() async {

    var result;
    _descController.text = beneficio_selected!;

    _beneficio.dependentes = _dependentesController.text;
    _beneficio.descricao = _descController.text;

    if (_beneficio.id == null)
    {
      BeneficioCriacaoDto beneficioCriacaoDto = BeneficioCriacaoDto(dependentes: _beneficio.dependentes, descricao: _beneficio.descricao);
      result = await beneficioController.CriarBeneficio(beneficioCriacaoDto);
     
    }
    else
    {
      result = await beneficioController.AtualizarBeneficio(_beneficio);
    }
    // List<Beneficio> res = await beneficioRepository.findAll();
    //                        setState(() {
    //                          _results = res;
    //                        });
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result[0].mensagem),
      ),
      
    );
    final response = await beneficioController.ListarBeneficios();

    List<Beneficio> res = response[0].dados ?? [];

    setState(() {
      _results = res;
    });

    // Limpar os campos após salvar
    _dependentesController.clear();
    _descController.clear();
 
  }

}
