// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Lancamento {
  int? id;
  String? valor;
  String? data;
  String? tipo;
  String? descricao;
  Lancamento({
    this.id,
    this.valor,
    this.data,
    this.tipo,
    this.descricao,
  });
  

  Lancamento copyWith({
    int? id,
    String? valor,
    String? data,
    String? tipo,
    String? descricao,
  }) {
    return Lancamento(
      id: id ?? this.id,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'valor': valor,
      'data': data,
      'tipo': tipo,
      'descricao': descricao,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      id: map['id'] != null ? map['id'] as int : null,
      valor: map['valor'] != null ? map['valor'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lancamento.fromJson(String source) => Lancamento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lancamento(id: $id, valor: $valor, data: $data, tipo: $tipo, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant Lancamento other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.valor == valor &&
      other.data == data &&
      other.tipo == tipo &&
      other.descricao == descricao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      valor.hashCode ^
      data.hashCode ^
      tipo.hashCode ^
      descricao.hashCode;
  }
}
