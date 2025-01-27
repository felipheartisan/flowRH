// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/controllers/login_controller.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';
import 'package:flow_rh/view/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routName = "login";
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final LoginController loginController =
      LoginController(LoginRepository(client: HttpClient()));

  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Input Fields
                  _buildTextField(
                    controller: _usuarioController,
                    label: 'Usuário',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _senhaController,
                    label: 'Token',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40.0),
                  // Login Button
                  ElevatedButton(
                    onPressed: () async {
                      var loginViewModel = LoginViewModel(
                        Login: _usuarioController.text,
                        Password: _senhaController.text,
                      );

                      final response =
                          await loginController.autenticar(loginViewModel);

                      if (response.status ?? false) {
                        Navigator.pushNamed(context, HomeScreen.routName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.mensagem ?? ''),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .deepPurple, // Correção: 'primary' substituído por 'backgroundColor'
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      required IconData icon,
      bool obscureText = false}) {
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
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15.0),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
