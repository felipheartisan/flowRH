import 'dart:convert';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

import '../models/response_model.dart';

abstract class IFuncionarioRepository {
  Future<List<ResponseModel<Funcionario>>> listarFuncionarios();
}

class FuncionarioRepository extends IFuncionarioRepository {
  final IHttpClient client;

  FuncionarioRepository({required this.client});

  @override
  Future<List<ResponseModel<Funcionario>>> listarFuncionarios() async {
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/Funcionario/ListarFuncionarios');

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Funcionario>.fromMap(
        responseMap,
        (map) => Funcionario.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Failed to load users');
    }
  }
}
