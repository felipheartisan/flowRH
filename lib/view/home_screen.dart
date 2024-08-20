import 'package:flow_rh/view/avaliation/FormAvaliationScreen.dart';
import 'package:flow_rh/view/avaliation/SearchAvaliationScreen.dart';
import 'package:flow_rh/view/benefits/SearchBenefitsScreen.dart';
import 'package:flow_rh/view/cashflow/SearchCashScreen.dart';
import 'package:flow_rh/view/functionary/SearchFunctionaryScreen.dart';
import 'package:flow_rh/view/functionary_benefits/SearchFuncBene.dart';
import 'package:flow_rh/view/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = "/"; 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> _colors = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.orange
  ];
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _startGradientAnimation();
  }

  void _startGradientAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      });
      _startGradientAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flow RH'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Folha de Pagamento'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                     context,
                     SearchCashScreen.routName
                    
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Colaboradores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  SearchFunctionaryScreen.routName
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Fluxo de Caixa'),
              onTap: () {
                Navigator.pop(context);
                 Navigator.pushNamed(
                     context,
                     SearchCashScreen.routName
                    
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // Implementação do que acontece ao clicar em 'Configurações'
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  LoginScreen.routName 
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 182, 201, 216),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            _buildButton(context, 'Funcionários', Icons.people, () {
              Navigator.pushNamed(
                context,
                SearchFunctionaryScreen.routName
              );
            }),
            _buildButton(context, 'Avaliação de funcionários', Icons.class_outlined, () {
              Navigator.pushNamed(
                context,
                SearchAvaliationScreen.routName
                
              );
            }),
            _buildButton(context, 'Benefícios', Icons.star, () {
              Navigator.pushNamed(
                context,
                SearchBenefitsScreen.routName
                
              );
            }),
            _buildButton(context, 'Beneficios de Funcionários', Icons.add_reaction, () {
              Navigator.pushNamed(
                context,
                SearchfuncbeneScreen.routName
                
              );
            }),
            _buildButton(context, 'Fluxo de caixa', Icons.payment, () {
              Navigator.pushNamed(
                     context,
                     SearchCashScreen.routName
                    
                );
            }),
             _buildButton(context, 'Sair', Icons.exit_to_app, () {
              Navigator.pushNamed(
                context,
                LoginScreen.routName 
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // primary: Colors.blue, // Cor do fundo do botão
        // onPrimary: Colors.white, // Cor do texto do botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
        ),
        padding: EdgeInsets.all(16),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 48), // Ícone do botão
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 18)), // Texto do botão
        ],
      ),
    );
  }
}

