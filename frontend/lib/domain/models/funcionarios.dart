// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Funcionario {
  int? idFuncionarios;
  String? nome;
  String? data_nascimento;
  String? salario;
  String? cargo;
  String? departamento;
  String? cpf;
  String? rg;
  String? telefone;
  String? rua;
  String? numero_casa;
  String? bairro;
  String? cidade;
  String? email;

  Funcionario({
    this.idFuncionarios,
    this.nome,
    this.data_nascimento,
    this.salario,
    this.cargo,
    this.departamento,
    this.cpf,
    this.rg,
    this.telefone,
    this.rua,
    this.numero_casa,
    this.bairro,
    this.cidade,
    this.email,
  });

  Funcionario copyWith({
    int? idFuncionarios,
    String? nome,
    String? data_nascimento,
    String? salario,
    String? cargo,
    String? departamento,
    String? cpf,
    String? rg,
    String? telefone,
    String? rua,
    String? numero_casa,
    String? bairro,
    String? cidade,
    String? email,
  }){
    return Funcionario(
      idFuncionarios: idFuncionarios?? this.idFuncionarios,
      nome: nome?? this.nome,
      data_nascimento: data_nascimento?? this.data_nascimento,
      salario: salario?? this.salario,
      cargo: cargo?? this.cargo,
      departamento: departamento?? this.departamento,
      cpf: cpf?? this.cpf,
      rg: rg?? this.rg,
      telefone: telefone?? this.telefone,
      rua: rua?? this.rua,
      numero_casa: numero_casa?? this.numero_casa,
      bairro: bairro?? this.bairro,
      cidade: cidade?? this.cidade,
      email: email?? this.email,
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'idFuncionarios': idFuncionarios,
      'nome': nome,
      'data_nascimento': data_nascimento,
     'salario': salario,
      'cargo': cargo,
      'departamento': departamento,
      'cpf': cpf,
      'rg': rg,
      'telefone': telefone,
      'rua': rua,
      'numero_casa': numero_casa,
      'bairro': bairro,
      'cidade': cidade,
      'email': email,
    };
  } 

  factory Funcionario.fromMap(Map<String, dynamic> map){
    return Funcionario(
      idFuncionarios: map['idFuncionarios'] != null ? map['idFuncionarios'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null ,
      data_nascimento: map['data_nascimento'] != null ? map['data_nascimento'] as String : null,
      salario: map['salario'] != null ? map['salario'] as String : null,
      cargo: map['cargo'] != null ? map['cargo'] as String : null,
      departamento: map['departamento'] != null ? map['departamento'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      rg: map['rg'] != null ? map['rg'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      rua: map['rua'] != null ? map['rua'] as String : null,
      numero_casa: map['numero_casa'] != null ? map['numero_casa'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Funcionario fromJson(String jsonString) => Funcionario.fromMap(json.decode(jsonString));

  @override
  String toString() {
    return 'Funcionario{idFuncionarios: $idFuncionarios, nome: $nome, data_nascimento: $data_nascimento, salario: $salario, cargo: $cargo, departamento: $departamento, cpf: $cpf, rg: $rg, telefone: $telefone, rua: $rua, numero_casa: $numero_casa, bairro: $bairro, cidade: $cidade, email: $email';
  }

  @override
  bool operator == (covariant Funcionario other) {
    if (identical(this, other)) return true;
    return idFuncionarios == other.idFuncionarios &&
        nome == other.nome &&
        data_nascimento == other.data_nascimento &&
        salario == other.salario &&
        cargo == other.cargo &&
        departamento == other.departamento &&
        cpf == other.cpf &&
        rg == other.rg &&
        telefone == other.telefone &&
        rua == other.rua &&
        numero_casa == other.numero_casa &&
        bairro == other.bairro &&
        cidade == other.cidade &&
        email == other.email;
  }

  @override
  int get hashCode {
    return idFuncionarios.hashCode ^
        nome.hashCode ^
        data_nascimento.hashCode ^
        salario.hashCode ^
        cargo.hashCode ^
        departamento.hashCode ^
        cpf.hashCode ^
        rg.hashCode ^
        telefone.hashCode ^
        rua.hashCode ^
        numero_casa.hashCode ^
        bairro.hashCode ^
        cidade.hashCode ^
        email.hashCode;
  }
}