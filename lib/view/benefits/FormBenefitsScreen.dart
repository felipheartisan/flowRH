import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/repositories/beneficios_repository.dart';
import 'package:flutter/material.dart';

class FormBenefitsScreen extends StatefulWidget {
  static const String routName = "form.benefit";

  @override
  _FormBenefitsScreenState createState() => _FormBenefitsScreenState();
}

class _FormBenefitsScreenState extends State<FormBenefitsScreen> {
   List<Beneficio> _results = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late BeneficiosRepository beneficioRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    beneficioRepository = BeneficiosRepository(databaseProvider);
    _results = await beneficioRepository.findAll();
    List<Beneficio> res = await beneficioRepository.findAll();
    setState(() {
      _results = res;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  
  TextEditingController _dependentesController = TextEditingController();
  TextEditingController _descController = TextEditingController();

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
        title: Text('Benefícios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
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
            SizedBox(height: 20),
              
              Text(
                'Descrição do benefício selecionado: ${_descController.text}',
                style: TextStyle(fontSize: 16),
              ),
               SizedBox(height: 20),
              TextFormField(
                    controller: _dependentesController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Dependentes',
                    ),
                  ),
                  SizedBox(height: 16.0),

                  Center(
                    child: ElevatedButton(
                      onPressed: () async{
                        _salvar();
                      }, 
                      child: Text('Salvar'),
                    )
                      
                  )

          ],
        ),
      ),
    );
  }

  void _salvar() async {
    _descController.text = beneficio_selected!;

    _beneficio.dependentes = _dependentesController.text;
    _beneficio.descricao = _descController.text;

    if (_beneficio.idBeneficios == null)
    {
      await beneficioRepository.insert(_beneficio);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Beneficio salvo'),
      ),
      
    );
    }
    else
    {
      await beneficioRepository.update(_beneficio);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Beneficio atualizado'),
      ),
    );
    }
    List<Beneficio> res = await beneficioRepository.findAll();
                           setState(() {
                             _results = res;
                           });
    

}
}
