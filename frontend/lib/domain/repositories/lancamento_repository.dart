import 'dart:convert';

import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/dto/lancamento_criacao_dto.dart';
import 'package:flow_rh/domain/http/http_client.dart';
import 'package:flow_rh/domain/models/lancamento_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class ILancamentoRepository {
  Future<List<ResponseModel<Lancamento>>> ListarCaixa();

  
  Future<List<ResponseModel<Lancamento>>> deletarLancamento(
      int idLancamento);

  Future<List<ResponseModel<Lancamento>>> InserirLancamento(
      LancamentoCriacaoDto lancamentoCriacaoDto);

  Future<List<ResponseModel<Lancamento>>> AtualizarLancamento(Lancamento lancamento);

}

class LancamentoRepository implements ILancamentoRepository {
  final IHttpClient client;

  LancamentoRepository({required this.client});

  @override
  Future<List<ResponseModel<Lancamento>>> ListarCaixa() async {
    var responseJson = await client.get(
        url: 'http://localhost:5003/api/Caixa/ListarCaixa');

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Lancamento>.fromMap(
        responseMap,
        (map) => Lancamento.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Failed to load users');
    }
  }
  
  @override
  Future<List<ResponseModel<Lancamento>>> deletarLancamento(int idLancamento) async {
    final responseJson = await client.delete(
        url: "http://localhost:5003/api/Caixa/DeletarLancamento",
        id: idLancamento);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Lancamento>.fromMap(
        responseMap,
        (map) => Lancamento.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao deletar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Lancamento>>> InserirLancamento(LancamentoCriacaoDto lancamentoCriacaoDto) async {
    final jsonBody = jsonEncode(lancamentoCriacaoDto.toMap());

    print(jsonBody);

    final responseJson = await client.post(
        url: 'http://localhost:5003/api/Caixa/CriarLancamento',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Lancamento>.fromMap(
        responseMap,
        (map) => Lancamento.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }
  
  @override
  Future<List<ResponseModel<Lancamento>>> AtualizarLancamento(Lancamento lancamento) async {
    final jsonBody = jsonEncode(lancamento.toMap());

    print(jsonBody);

    final responseJson = await client.put(
        url: 'http://localhost:5003/api/Caixa/EditarCaixa',
        body: jsonBody);

    print(responseJson);

    if (responseJson != null) {
      final responseMap = jsonDecode(responseJson.body) as Map<String, dynamic>;

      var result = ResponseModel<Lancamento>.fromMap(
        responseMap,
        (map) => Lancamento.fromMap(map),
      );

      return [result];
    } else {
      throw Exception('Falha ao salvar o usuário');
    }
  }


}
