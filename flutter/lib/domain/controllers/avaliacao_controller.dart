import 'dart:convert';

import 'package:flow_rh/domain/dto/avaliacao_criacao_dto.dart';
import 'package:flow_rh/domain/dto/avaliacao_edicao_dto.dart';
import 'package:flow_rh/domain/dto/funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/models/usuario_model.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';
import 'package:flow_rh/domain/viewmodel/login_viewmodel.dart';
import 'package:http/http.dart';

class AvaliacaoController { 

  final IAvaliacaoRepository repository;

  AvaliacaoController(this.repository);

  Future<List<ResponseModel<Avaliacao>>> listarAvaliacoes() async {
  // Converte o ViewModel para JSON antes de enviar

  // Envia para o repositório
  final result = await repository.listarAvaliacoes();
  return result;
}

  Future<List<ResponseModel<Avaliacao>>> deletarAvaliacao(int idAvaliacao) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.deletarAvaliacao(idAvaliacao);    
    return result;
  }

  Future<List<ResponseModel<Avaliacao>>> criarAvaliacao(AvaliacaoCriacaoDto avaliacaoCriacaoDto) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.criarAvaliacao(avaliacaoCriacaoDto);    
    return result;
  }

  Future<List<ResponseModel<Avaliacao>>> atualizarAvaliacao(AvaliacaoEdicaoDto avaliacaoEdicaoDto) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.atualizarAvaliacao(avaliacaoEdicaoDto);    
    return result;
  }

  

}