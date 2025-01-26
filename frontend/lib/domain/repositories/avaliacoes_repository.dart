import 'dart:convert';

import 'package:flow_rh/domain/dto/avaliacao_criacao_dto.dart';
import 'package:flow_rh/domain/dto/funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';


abstract class IAvaliacaoRepository {
  Future<List<ResponseModel<Avaliacao>>> listarAvaliacoes();
  Future<List<ResponseModel<Avaliacao>>> criarAvaliacao(
      AvaliacaoCriacaoDto avaliacaoCriacaoDto);

  Future<List<ResponseModel<Avaliacao>>> deletarAvaliacao(
  int idAvaliacao);

  // Future<List<ResponseModel<Funcionario>>> atualizarFuncionario(
  //     Funcionario funcionarioEdicaoDto);
}

class AvaliacaoRepository extends IAvaliacaoRepository {
  final IHttpClient client;

  AvaliacaoRepository({required this.client});

  @override
  Future<List<ResponseModel<Avaliacao>>> listarAvaliacoes() async {
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/Avaliacao/Listaravaliacaos');

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Avaliacao>.fromMap(
        responseMap,
        (map) => Avaliacao.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Failed to load users');
    }
  }
  
  @override
  Future<List<ResponseModel<Avaliacao>>> deletarAvaliacao(int idAvaliacao) async {
     final responseJson = await client.delete(
        url: "http://localhost:5003/api/Avaliacao/Deletaravaliacao",
        id: idAvaliacao);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Avaliacao>.fromMap(
        responseMap,
        (map) => Avaliacao.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao deletar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Avaliacao>>> criarAvaliacao(AvaliacaoCriacaoDto avaliacaoCriacaoDto) async {
    final jsonBody = jsonEncode(avaliacaoCriacaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.post(
        url: 'http://localhost:5003/api/Avaliacao/Criaravaliacao',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Avaliacao>.fromMap(
        responseMap,
        (map) => Avaliacao.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }

 
}
