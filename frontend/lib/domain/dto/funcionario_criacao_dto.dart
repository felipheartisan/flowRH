// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FuncionarioCriacaoDto {

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

  FuncionarioCriacaoDto({
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


  FuncionarioCriacaoDto copyWith({
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
  }) {
    return FuncionarioCriacaoDto(
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      salario: salario ?? this.salario,
      cargo: cargo ?? this.cargo,
      departamento: departamento ?? this.departamento,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      telefone: telefone ?? this.telefone,
      rua: rua ?? this.rua,
      numeroCasa: numeroCasa ?? this.numeroCasa,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory FuncionarioCriacaoDto.fromMap(Map<String, dynamic> map) {
    return FuncionarioCriacaoDto(
      nome: map['nome'] != null ? map['nome'] as String : null,
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

  factory FuncionarioCriacaoDto.fromJson(String source) => FuncionarioCriacaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FuncionarioCriacaoDto(nome: $nome, dataNascimento: $dataNascimento, salario: $salario, cargo: $cargo, departamento: $departamento, cpf: $cpf, rg: $rg, telefone: $telefone, rua: $rua, numeroCasa: $numeroCasa, bairro: $bairro, cidade: $cidade, email: $email)';
  }

  @override
  bool operator ==(covariant FuncionarioCriacaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.dataNascimento == dataNascimento &&
      other.salario == salario &&
      other.cargo == cargo &&
      other.departamento == departamento &&
      other.cpf == cpf &&
      other.rg == rg &&
      other.telefone == telefone &&
      other.rua == rua &&
      other.numeroCasa == numeroCasa &&
      other.bairro == bairro &&
      other.cidade == cidade &&
      other.email == email;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
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
