import 'package:flow_rh/domain/dto/beneficio_funcionario_criacao_dto.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/models/response_model.dart';
import 'package:flow_rh/domain/repositories/beneficios_funcionarios_repository.dart';

class BeneficioFuncionarioController {

  final IBeneficiosFuncionariosRepository repository;

  BeneficioFuncionarioController(this.repository);

  Future<List<ResponseModel<BeneficiosFuncionarios>>> listarBeneficiosFuncionarios() async {
    final result = await repository.getBeneficiosFuncionarios();
    return result;
  } 

  Future<List<ResponseModel<BeneficiosFuncionarios>>> addBeneficiosFuncionarios(BeneficioFuncionarioCriacaoDto beneficiosFuncionarioCriacaoDto) async {
    final result = await repository.addBeneficiosFuncionarios(beneficiosFuncionarioCriacaoDto);    
    return result;
  }

  Future<List<ResponseModel<BeneficiosFuncionarios>>> deletarBeneficiosFuncionarios(int id) async {
    final result = await repository.deleteBeneficiosFuncionarios(id);    
    return result;
  }

}