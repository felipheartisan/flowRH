import 'dart:convert';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/dto/funcionario/funcionario_criacao_dto.dart';
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
  Future<List<ResponseModel<Funcionario>>> criarFuncionario(
      FuncionarioCriacaoDto funcionarioCriacaoDto);

  Future<List<ResponseModel<Funcionario>>> deletarFuncionario(
      int idFuncionario);

  Future<List<ResponseModel<Funcionario>>> atualizarFuncionario(
      Funcionario funcionarioEdicaoDto);
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

  @override
  Future<List<ResponseModel<Funcionario>>> criarFuncionario(
      FuncionarioCriacaoDto funcionarioCriacaoDto) async {
    final jsonBody = jsonEncode(funcionarioCriacaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.post(
        url: 'http://localhost:5003/api/Funcionario/CriarFuncionario',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Funcionario>.fromMap(
        responseMap,
        (map) => Funcionario.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }

  @override
  Future<List<ResponseModel<Funcionario>>> deletarFuncionario(
      int idFuncionario) async {
    final responseJson = await client.delete(
        url: "http://localhost:5003/api/Funcionario/DeletarFuncionario",
        id: idFuncionario);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Funcionario>.fromMap(
        responseMap,
        (map) => Funcionario.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao deletar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Funcionario>>> atualizarFuncionario(Funcionario funcionarioEdicaoDto) async {
     final jsonBody = jsonEncode(funcionarioEdicaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.put(
        url: 'http://localhost:5003/api/Funcionario/EditarFuncionario',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Funcionario>.fromMap(
        responseMap,
        (map) => Funcionario.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }
}
