import 'dart:convert';

import 'package:flow_rh/domain/dto/beneficio_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/response_model.dart';

abstract class IBeneficiosRepository {
  Future<List<ResponseModel<Beneficio>>> listarBeneficios();

  Future<List<ResponseModel<Beneficio>>> deletarBeneficio(int idBeneficio);

  Future<List<ResponseModel<Beneficio>>> criarBeneficio(BeneficioCriacaoDto beneficioCriacaoDto);

  Future<List<ResponseModel<Beneficio>>> editarBeneficio(Beneficio beneficioEdicaoDto);
}

class BeneficiosRepository implements IBeneficiosRepository {
  final IHttpClient client;

  BeneficiosRepository({required this.client});
  
  @override
  Future<List<ResponseModel<Beneficio>>> listarBeneficios() async{
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/Beneficio/ListarBeneficios');

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Beneficio>.fromMap(
        responseMap,
        (map) => Beneficio.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Failed to load users');
    }
  }
  
  @override
  Future<List<ResponseModel<Beneficio>>> deletarBeneficio(int idBeneficio) async{
    final responseJson = await client.delete(
        url: "http://localhost:5003/api/Beneficio/DeletarBeneficio",
        id: idBeneficio);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Beneficio>.fromMap(
        responseMap,
        (map) => Beneficio.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao deletar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Beneficio>>> criarBeneficio(BeneficioCriacaoDto beneficioCriacaoDto) async{
    final jsonBody = jsonEncode(beneficioCriacaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.post(
        url: 'http://localhost:5003/api/Beneficio/CriarBeneficio',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Beneficio>.fromMap(
        responseMap,
        (map) => Beneficio.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Beneficio>>> editarBeneficio(Beneficio beneficioEdicaoDto) async{
    final jsonBody = jsonEncode(beneficioEdicaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.put(
        url: 'http://localhost:5003/api/Beneficio/EditarBeneficio',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Beneficio>.fromMap(
        responseMap,
        (map) => Beneficio.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }



}
