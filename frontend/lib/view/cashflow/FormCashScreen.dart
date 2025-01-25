import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/cash.dart';
import 'package:flow_rh/domain/repositories/cash_repository.dart';
import 'package:flutter/material.dart';

class FormCashScreen extends StatefulWidget {
  static const String routName = "form.cash";

  const FormCashScreen({super.key}); 

  @override
  _FormCashScreenState createState() => _FormCashScreenState();
}

class _FormCashScreenState extends State<FormCashScreen> {  
    // ignore: unused_field
    List<Cash> _results = [];

  DatabaseProvider databaseProvider = DatabaseProvider();
  late CashRepository cashRepository;
  
  @override
  void initState(){
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await databaseProvider.open();
    cashRepository = CashRepository(databaseProvider);
    _results = await cashRepository.findAll();
    List<Cash> res = await cashRepository.findAll();
    setState(() {
      _results = res;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _catController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = ['Entrada', 'Saída'];

  Cash _cash = Cash();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
      _cash = ModalRoute.of(context)!.settings.arguments as Cash;
      _valueController.text = _cash.valor!;
      _descController.text = _cash.descricao!;
      _dataController.text = _cash.data!;
      _catController.text= _cash.categoria!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluxo de Caixa'),
      ),body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    controller: _valueController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um valor';
                      }
                      final number = num.tryParse(value);
                      if (number == null) {
                        return 'Por favor, insira um número válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Campo de Data
                  TextFormField(
                    controller: _dataController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                    ),
                  ),

                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: _catController,
                    decoration: const InputDecoration(labelText: 'Categoria'),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),

                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          
                          if(_catController.text != "Entrada" && _catController.text != "Saída"){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, selecione uma categoria válida (Entrada ou Saída)')));
                            
                          }else{
                            _salvar();
                          }
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),



            ],))
        ],),
      
      
      ),
    );

            
            

  }

  void _salvar() async {

    _cash.valor = _valueController.text;
    _cash.data = _dataController.text;
    _cash.categoria = _catController.text;
    _cash.descricao = _descController.text;

    if (_cash.idCash == null)
    {
      await cashRepository.insert(_cash);
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Fluxo de caixa salvo'),
      ),
      
    );
    }
    else
    {
      await cashRepository.update(_cash);
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Fluxo de caixa atualizado'),
      ),
    );
    }
    List<Cash> res = await cashRepository.findAll();
                           setState(() {
                             _results = res;
                           });
    

}

}



