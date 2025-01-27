import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/lancamento_controller.dart';
import 'package:flow_rh/domain/dto/lancamento_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/lancamento_model.dart';
import 'package:flow_rh/domain/repositories/lancamento_repository.dart';
import 'package:flutter/material.dart';

class FormLancamentoScreen extends StatefulWidget {
  static const String routName = "form.Lancamento";

  const FormLancamentoScreen({super.key});

  @override
  _FormLancamentoScreenState createState() => _FormLancamentoScreenState();
}

class _FormLancamentoScreenState extends State<FormLancamentoScreen> {
  // ignore: unused_field
  List<Lancamento> _results = [];

  final LancamentoController lancamentoController =
      LancamentoController(LancamentoRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    final response = await lancamentoController.listarLancamentos();
    List<Lancamento> res = response[0].dados ?? [];
    print(res);
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

  Lancamento _Lancamento = Lancamento();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      _Lancamento = ModalRoute.of(context)!.settings.arguments as Lancamento;
      _valueController.text = _Lancamento.valor!;
      _descController.text = _Lancamento.descricao!;
      _dataController.text = _Lancamento.data!;
      _catController.text = _Lancamento.tipo!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluxo de Caixa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _valueController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                            if (_catController.text != "Entrada" &&
                                _catController.text != "Saída") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Por favor, selecione uma categoria válida (Entrada ou Saída)')));
                            } else {
                              _salvar();
                            }
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _salvar() async {
    var result;
    _Lancamento.valor = _valueController.text;
    _Lancamento.data = _dataController.text;
    _Lancamento.tipo = _catController.text;
    _Lancamento.descricao = _descController.text;

    if (_Lancamento.id == null) {

     var lancamentoCriacaoDto = LancamentoCriacaoDto(
        valor: _Lancamento.valor,
        data: _Lancamento.data,
        tipo: _Lancamento.tipo,
        descricao: _Lancamento.descricao,
      );
     
     result = await lancamentoController.InserirLancamento(lancamentoCriacaoDto);

    } else {
    
      result = await lancamentoController.AtualizarLancamento(_Lancamento);
    
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result[0].mensagem),
      ),
    );

    final response = await lancamentoController.listarLancamentos();

    List<Lancamento> res = response[0].dados ?? [];

    setState(() {
      _results = res;
    });

    // Limpar os campos após salvar
    _valueController.clear();
    _dataController.clear();
    _descController.clear();
    _catController.clear();

  }
}
