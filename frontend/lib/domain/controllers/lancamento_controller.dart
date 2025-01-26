import 'package:flow_rh/domain/models/lancamento_model.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/repositories/lancamento_repository.dart';

class LancamentoController { 

  final ILancamentoRepository repository;

  LancamentoController(this.repository);

  Future<List<ResponseModel<Lancamento>>> listarLancamentos() async {
  // Converte o ViewModel para JSON antes de enviar

  // Envia para o repositório
  final result = await repository.ListarCaixa();
  return result;
}
 
 Future<List<ResponseModel<Lancamento>>> deletarFuncionario(
      int idLancamento) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.deletarLancamento(idLancamento);    
    return result;
  }


}