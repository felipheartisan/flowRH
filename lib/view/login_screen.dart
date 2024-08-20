
import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';
import 'package:flow_rh/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class LoginScreen extends StatelessWidget {
  static const String routName = "login";

  TextEditingController _usuarioController = new TextEditingController();
  TextEditingController _tokenController = new TextEditingController();

  DatabaseProvider databaseProvider = DatabaseProvider();
  late LoginRepository loginRepository;

  void initDatabase() async {
    await databaseProvider.open();
    loginRepository = LoginRepository(databaseProvider);
  }

  @override
  Widget build(BuildContext context) {
    initDatabase();
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Centered Login Form
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Input Fields
                  _buildTextField(
                    controller: _usuarioController,
                    label: 'Usuário',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _tokenController,
                    label: 'Token',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 40.0),
                  // Login Button
                  ElevatedButton(
                    onPressed: () async {
                      
                      bool isValidUser = await loginRepository.validateUser(_usuarioController.text,_tokenController.text);
                      print(isValidUser);
                      if (isValidUser) {
                        Navigator.pushNamed(context, HomeScreen.routName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Usuário ou senha inválidos'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Correção: 'primary' substituído por 'backgroundColor'
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller,required String label, required IconData icon, bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: label,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(15.0),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }


}


