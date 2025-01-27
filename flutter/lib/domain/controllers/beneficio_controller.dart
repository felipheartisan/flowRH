import 'package:flow_rh/domain/dto/beneficio_criacao_dto.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/repositories/beneficios_repository.dart';

class BeneficioController {
  final IBeneficiosRepository repository;

  BeneficioController(this.repository);

  Future<List<ResponseModel<Beneficio>>> ListarBeneficios() async {
    // Converte o ViewModel para JSON antes de enviar

    // Envia para o repositório
    final result = await repository.listarBeneficios();
    return result;
  }

  Future<List<ResponseModel<Beneficio>>> DeletarBeneficio(
      int idBeneficio) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.deletarBeneficio(idBeneficio);
    return result;
  }

  Future<List<ResponseModel<Beneficio>>> CriarBeneficio(
      BeneficioCriacaoDto beneficioCriacaoDto) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.criarBeneficio(beneficioCriacaoDto);
    return result;
  }

  Future<List<ResponseModel<Beneficio>>> AtualizarBeneficio(
      Beneficio beneficioEdicaoDto) async {
    // Converte o ViewModel para JSON antes de enviar
    // Envia para o repositório
    final result = await repository.editarBeneficio(beneficioEdicaoDto);
    return result;
  }
}
