import 'dart:convert';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

import '../models/response_model.dart';

abstract class ILoginRepository {
  Future<ResponseModel<UsuarioModel>> autenticar(LoginViewModel loginViewModel);
  Future<List<ResponseModel<UsuarioModel>>> listarTodos();
  Future<List<ResponseModel<UsuarioModel>>> excluir(int id);
  Future<List<ResponseModel<UsuarioModel>>> alterar(
      LoginViewModel loginViewModel);
  Future<List<ResponseModel<UsuarioModel>>> inserir(
      LoginViewModel loginViewModel);
  Future<List<ResponseModel<UsuarioModel>>> buscarPorId(int id);
}

class LoginRepository extends ILoginRepository {
  final IHttpClient client;

  LoginRepository({required this.client});

  @override
  Future<List<ResponseModel<UsuarioModel>>> alterar(
      LoginViewModel loginViewModel) {
    // TODO: implement alterar
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseModel<UsuarioModel>>> buscarPorId(int id) {
    // TODO: implement buscarPorId
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseModel<UsuarioModel>>> excluir(int id) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseModel<UsuarioModel>>> inserir(
      LoginViewModel loginViewModel) {
    // TODO: implement inserir
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseModel<UsuarioModel>>> listarTodos() async {
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/Usuario/ListarUsuarios');

    if (responseJson.StatusCode == 200) {
      final List<Map<String, dynamic>> responseMap =
          jsonDecode(responseJson.body);

      return responseMap.map<ResponseModel<UsuarioModel>>((item) {
        return ResponseModel<UsuarioModel>(
          dados: [UsuarioModel.fromMap(item)],
          status: item['status'] as bool,
          mensagem: item['mensagem'] as String,
        );
      }).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<ResponseModel<UsuarioModel>> autenticar(
      LoginViewModel loginViewModel) async {

    final jsonBody = jsonEncode(loginViewModel.toMap());

    print(jsonBody);

    final responseJson = await client.post(url: 'http://localhost:5003/api/Usuario/Autenticar', body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      return ResponseModel<UsuarioModel>.fromMap(
        responseMap,
        (map) => UsuarioModel.fromMap(map),
      );
    } else {
      throw Exception('Falha ao autenticar o usuário');
    }
  }
}
