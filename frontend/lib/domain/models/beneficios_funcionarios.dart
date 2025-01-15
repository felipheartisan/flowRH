// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';



class BeneficiosFuncionarios {
  int? id_beneficios_funcionarios;
  int? idBeneficios;
  int? idFuncionarios;
  String? nome_funcionario;
  String? descricao_beneficio;
  BeneficiosFuncionarios( {
    this.id_beneficios_funcionarios,
    this.idBeneficios,
    this.idFuncionarios,
    this.nome_funcionario,
    this.descricao_beneficio,
  } 
    
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBeneficios': idBeneficios,
      'idFuncionarios': idFuncionarios,
      'id_beneficios_funcionarios': id_beneficios_funcionarios,
    };
  }

  factory BeneficiosFuncionarios.fromMap(Map<String, dynamic> map) {
    return BeneficiosFuncionarios(
      id_beneficios_funcionarios: map['id_beneficios_funcionarios'],
      idBeneficios: map['idBeneficios'],
      idFuncionarios: map['idFuncionarios'],
      nome_funcionario: map['NomeFuncionario'],
      descricao_beneficio: map['NomeBeneficio'],
    );
  }




  String toJson() => json.encode(toMap());

  factory BeneficiosFuncionarios.fromJson(String source) => BeneficiosFuncionarios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BeneficiosFuncionarios(idBeneficios: $idBeneficios, idFuncionarios: $idFuncionarios, nome_funcionario: $nome_funcionario, descricao_beneficio: $descricao_beneficio)';
  }

  @override
  bool operator ==(covariant BeneficiosFuncionarios other) {
    if (identical(this, other)) return true;
  
    return 
      other.idBeneficios == idBeneficios &&
      other.idFuncionarios == idFuncionarios &&
      other.nome_funcionario == nome_funcionario &&
      other.descricao_beneficio == descricao_beneficio;
  }

  @override
  int get hashCode {
    return idBeneficios.hashCode ^
      idFuncionarios.hashCode ^
      nome_funcionario.hashCode ^
      descricao_beneficio.hashCode;
  }
}
