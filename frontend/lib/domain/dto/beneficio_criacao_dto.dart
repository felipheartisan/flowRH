// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BeneficioCriacaoDto {
  String? dependentes;
  String? descricao;
  BeneficioCriacaoDto({
    this.dependentes,
    this.descricao,
  });
  
  

  BeneficioCriacaoDto copyWith({
    String? dependentes,
    String? descricao,
  }) {
    return BeneficioCriacaoDto(
      dependentes: dependentes ?? this.dependentes,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dependentes': dependentes,
      'descricao': descricao,
    };
  }

  factory BeneficioCriacaoDto.fromMap(Map<String, dynamic> map) {
    return BeneficioCriacaoDto(
      dependentes: map['dependentes'] != null ? map['dependentes'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficioCriacaoDto.fromJson(String source) => BeneficioCriacaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BeneficioCriacaoDto(dependentes: $dependentes, descricao: $descricao)';

  @override
  bool operator ==(covariant BeneficioCriacaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.dependentes == dependentes &&
      other.descricao == descricao;
  }

  @override
  int get hashCode => dependentes.hashCode ^ descricao.hashCode;
}
