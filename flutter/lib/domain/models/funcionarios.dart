// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Funcionario {
  int? id;
  String? nome;
  String? dataNascimento;
  String? salario;
  String? cargo;
  String? departamento;
  String? cpf;
  String? rg;
  String? telefone;
  String? rua;
  String? numeroCasa;
  String? bairro;
  String? cidade;
  String? email;

  Funcionario({
    this.id,
    this.nome,
    this.dataNascimento,
    this.salario,
    this.cargo,
    this.departamento,
    this.cpf,
    this.rg,
    this.telefone,
    this.rua,
    this.numeroCasa,
    this.bairro,
    this.cidade,
    this.email,
  });

  Funcionario copyWith({
    int? id,
    String? nome,
    String? dataNascimento,
    String? salario,
    String? cargo,
    String? departamento,
    String? cpf,
    String? rg,
    String? telefone,
    String? rua,
    String? numeroCasa,
    String? bairro,
    String? cidade,
    String? email,
  }){
    return Funcionario(
      id: id?? this.id,
      nome: nome?? this.nome,
      dataNascimento: dataNascimento?? this.dataNascimento,
      salario: salario?? this.salario,
      cargo: cargo?? this.cargo,
      departamento: departamento?? this.departamento,
      cpf: cpf?? this.cpf,
      rg: rg?? this.rg,
      telefone: telefone?? this.telefone,
      rua: rua?? this.rua,
      numeroCasa: numeroCasa?? this.numeroCasa,
      bairro: bairro?? this.bairro,
      cidade: cidade?? this.cidade,
      email: email?? this.email,
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'dataNascimento': dataNascimento,
     'salario': salario,
      'cargo': cargo,
      'departamento': departamento,
      'cpf': cpf,
      'rg': rg,
      'telefone': telefone,
      'rua': rua,
      'numeroCasa': numeroCasa,
      'bairro': bairro,
      'cidade': cidade,
      'email': email,
    };
  } 

  factory Funcionario.fromMap(Map<String, dynamic> map){
    return Funcionario(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null ,
      dataNascimento: map['dataNascimento'] != null ? map['dataNascimento'] as String : null,
      salario: map['salario'] != null ? map['salario'] as String : null,
      cargo: map['cargo'] != null ? map['cargo'] as String : null,
      departamento: map['departamento'] != null ? map['departamento'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      rg: map['rg'] != null ? map['rg'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      rua: map['rua'] != null ? map['rua'] as String : null,
      numeroCasa: map['numeroCasa'] != null ? map['numeroCasa'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Funcionario fromJson(String jsonString) => Funcionario.fromMap(json.decode(jsonString));

  @override
  String toString() {
    return 'Funcionario{id: $id, nome: $nome, dataNascimento: $dataNascimento, salario: $salario, cargo: $cargo, departamento: $departamento, cpf: $cpf, rg: $rg, telefone: $telefone, rua: $rua, numeroCasa: $numeroCasa, bairro: $bairro, cidade: $cidade, email: $email';
  }

  @override
  bool operator == (covariant Funcionario other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        nome == other.nome &&
        dataNascimento == other.dataNascimento &&
        salario == other.salario &&
        cargo == other.cargo &&
        departamento == other.departamento &&
        cpf == other.cpf &&
        rg == other.rg &&
        telefone == other.telefone &&
        rua == other.rua &&
        numeroCasa == other.numeroCasa &&
        bairro == other.bairro &&
        cidade == other.cidade &&
        email == other.email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        dataNascimento.hashCode ^
        salario.hashCode ^
        cargo.hashCode ^
        departamento.hashCode ^
        cpf.hashCode ^
        rg.hashCode ^
        telefone.hashCode ^
        rua.hashCode ^
        numeroCasa.hashCode ^
        bairro.hashCode ^
        cidade.hashCode ^
        email.hashCode;
  }

}