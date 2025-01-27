// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';

class BeneficiosFuncionarios {
  int? id;
  Funcionario? funcionario;
  Beneficio? beneficio;
  BeneficiosFuncionarios({
    this.id,
    this.funcionario,
    this.beneficio,
  });
  
  

  BeneficiosFuncionarios copyWith({
    int? id,
    Funcionario? funcionario,
    Beneficio? beneficio,
  }) {
    return BeneficiosFuncionarios(
      id: id ?? this.id,
      funcionario: funcionario ?? this.funcionario,
      beneficio: beneficio ?? this.beneficio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'funcionario': funcionario?.toMap(),
      'beneficio': beneficio?.toMap(),
    };
  }

  factory BeneficiosFuncionarios.fromMap(Map<String, dynamic> map) {
    return BeneficiosFuncionarios(
      id: map['id'] != null ? map['id'] as int : null,
      funcionario: map['funcionario'] != null ? Funcionario.fromMap(map['funcionario'] as Map<String,dynamic>) : null,
      beneficio: map['beneficio'] != null ? Beneficio.fromMap(map['beneficio'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficiosFuncionarios.fromJson(String source) => BeneficiosFuncionarios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BeneficiosFuncionarios(id: $id, funcionario: $funcionario, beneficio: $beneficio)';

  @override
  bool operator ==(covariant BeneficiosFuncionarios other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.funcionario == funcionario &&
      other.beneficio == beneficio;
  }

  @override
  int get hashCode => id.hashCode ^ funcionario.hashCode ^ beneficio.hashCode;
}
