// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  int id;
  String nome;
  String salt;
  String email;
  String senha;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.salt,
    required this.email,
    required this.senha
  });

  UsuarioModel copyWith({
    int? id,
    String? nome,
    String? salt,
    String? email,
    String? senha,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      salt: salt ?? this.salt,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'salt': salt,
      'email': email,
      'senha': senha,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      salt: map['salt'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, salt: $salt, email: $email, senha: $senha)';
  }

  @override
  bool operator ==(covariant UsuarioModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome &&
      other.salt == salt &&
      other.email == email &&
      other.senha == senha;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nome.hashCode ^
      salt.hashCode ^
      email.hashCode ^
      senha.hashCode;
  }
}
