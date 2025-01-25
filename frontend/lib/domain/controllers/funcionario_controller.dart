import 'dart:convert';

import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:http/http.dart';

class FuncionarioController { 

  final IFuncionarioRepository repository;

  FuncionarioController(this.repository);

  Future<List<ResponseModel<Funcionario>>> listarFuncionarios() async {
  // Converte o ViewModel para JSON antes de enviar

  // Envia para o repositório
  final result = await repository.listarFuncionarios();
  return result;
}

}