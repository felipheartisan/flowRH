// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Beneficio {
  int? idBeneficios;
  String? dependentes;
  String? descricao;
  Beneficio({
    this.idBeneficios,
    this.dependentes,
    this.descricao
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBeneficios': idBeneficios,
      'dependentes': dependentes,
      'descricao': descricao,
    };
  }

  factory Beneficio.fromMap(Map<String, dynamic> map) {
    return Beneficio(
      idBeneficios: map['idBeneficios'] != null ? map['idBeneficios'] as int : null,
      dependentes: map['dependentes'] != null ? map['dependentes'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }


  Beneficio copyWith({
    int? idBeneficios,
    String? dependentes,
    String? descricao,
  }) {
    return Beneficio(
      idBeneficios: idBeneficios ?? this.idBeneficios,
      dependentes: dependentes ?? this.dependentes,
      descricao: descricao ?? this.descricao,
    );
  }

  String toJson() => json.encode(toMap());

  factory Beneficio.fromJson(String source) => Beneficio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Beneficio(idBeneficios: $idBeneficios, dependentes: $dependentes, descricao: $descricao)';

  @override
  bool operator ==(covariant Beneficio other) {
    if (identical(this, other)) return true;
  
    return 
      other.idBeneficios == idBeneficios &&
      other.dependentes == dependentes &&
      other.descricao == descricao;
  }

  @override
  int get hashCode => idBeneficios.hashCode ^ dependentes.hashCode ^ descricao.hashCode;
}
