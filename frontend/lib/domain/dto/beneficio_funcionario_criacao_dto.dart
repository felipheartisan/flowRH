// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BeneficioFuncionarioCriacaoDto {
  int? funcionarioId;
  int? beneficioId;
  BeneficioFuncionarioCriacaoDto({
    this.funcionarioId,
    this.beneficioId,
  });

  BeneficioFuncionarioCriacaoDto copyWith({
    int? funcionarioId,
    int? beneficioId,
  }) {
    return BeneficioFuncionarioCriacaoDto(
      funcionarioId: funcionarioId ?? this.funcionarioId,
      beneficioId: beneficioId ?? this.beneficioId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'funcionarioId': funcionarioId,
      'beneficioId': beneficioId,
    };
  }

  factory BeneficioFuncionarioCriacaoDto.fromMap(Map<String, dynamic> map) {
    return BeneficioFuncionarioCriacaoDto(
      funcionarioId: map['funcionarioId'] != null ? map['funcionarioId'] as int : null,
      beneficioId: map['beneficioId'] != null ? map['beneficioId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficioFuncionarioCriacaoDto.fromJson(String source) => BeneficioFuncionarioCriacaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BeneficioFuncionarioCriacaoDto(funcionarioId: $funcionarioId, beneficioId: $beneficioId)';

  @override
  bool operator ==(covariant BeneficioFuncionarioCriacaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.funcionarioId == funcionarioId &&
      other.beneficioId == beneficioId;
  }

  @override
  int get hashCode => funcionarioId.hashCode ^ beneficioId.hashCode;
}
