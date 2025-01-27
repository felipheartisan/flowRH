import 'dart:convert';

import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:http/http.dart';

class LoginController { 

  final ILoginRepository repository;

  LoginController(this.repository);

  Future<ResponseModel<UsuarioModel>> autenticar(LoginViewModel viewModel) async {
  // Converte o ViewModel para JSON antes de enviar

  // Envia para o repositório
  final result = await repository.autenticar(viewModel);
  return result;
}

}