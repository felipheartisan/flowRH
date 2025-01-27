// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BeneficioFuncionarioCriacaoDto {
  int? idFuncionario;
  int? idBeneficio;
  BeneficioFuncionarioCriacaoDto({
    this.idFuncionario,
    this.idBeneficio,
  });

  BeneficioFuncionarioCriacaoDto copyWith({
    int? idFuncionario,
    int? idBeneficio,
  }) {
    return BeneficioFuncionarioCriacaoDto(
      idFuncionario: idFuncionario ?? this.idFuncionario,
      idBeneficio: idBeneficio ?? this.idBeneficio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFuncionario': idFuncionario,
      'idBeneficio': idBeneficio,
    };
  }

  factory BeneficioFuncionarioCriacaoDto.fromMap(Map<String, dynamic> map) {
    return BeneficioFuncionarioCriacaoDto(
      idFuncionario: map['idFuncionario'] != null ? map['idFuncionario'] as int : null,
      idBeneficio: map['idBeneficio'] != null ? map['idBeneficio'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficioFuncionarioCriacaoDto.fromJson(String source) => BeneficioFuncionarioCriacaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BeneficioFuncionarioCriacaoDto(idFuncionario: $idFuncionario, idBeneficio: $idBeneficio)';

  @override
  bool operator ==(covariant BeneficioFuncionarioCriacaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.idFuncionario == idFuncionario &&
      other.idBeneficio == idBeneficio;
  }

  @override
  int get hashCode => idFuncionario.hashCode ^ idBeneficio.hashCode;
}
