import 'dart:convert';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/dto/beneficio_funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class IBeneficiosFuncionariosRepository{
  Future<List<ResponseModel<BeneficiosFuncionarios>>> getBeneficiosFuncionarios();
  Future<List<ResponseModel<BeneficiosFuncionarios>>> addBeneficiosFuncionarios(BeneficioFuncionarioCriacaoDto beneficiosFuncionarioCriacaoDto);
  Future<List<ResponseModel<BeneficiosFuncionarios>>> deleteBeneficiosFuncionarios(int id);
}

class BeneficiosFuncionariosRepository implements IBeneficiosFuncionariosRepository{
  final IHttpClient client;

  BeneficiosFuncionariosRepository({required this.client});
  
  @override
  Future<List<ResponseModel<BeneficiosFuncionarios>>> addBeneficiosFuncionarios(beneficiosFuncionarioCriacaoDto) async {
    final jsonBody = jsonEncode(beneficiosFuncionarioCriacaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.post(
        url: 'http://localhost:5003/api/BeneficioFuncionario/VincularBeneficioFuncionario',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<BeneficiosFuncionarios>.fromMap(
        responseMap,
        (map) => BeneficiosFuncionarios.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<BeneficiosFuncionarios>>> deleteBeneficiosFuncionarios(int id) async{
    final responseJson = await client.delete(
        url: "http://localhost:5003/api/BeneficioFuncionario/DeletarVinculoBeneficioFuncionario",
        id: id);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<BeneficiosFuncionarios>.fromMap(
        responseMap,
        (map) => BeneficiosFuncionarios.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao deletar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<BeneficiosFuncionarios>>> getBeneficiosFuncionarios() async{
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/BeneficioFuncionario/ListarBeneficiosFuncionarios');

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<BeneficiosFuncionarios>.fromMap(
        responseMap,
        (map) => BeneficiosFuncionarios.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Failed to load users');
    }
  }



}