// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cash {
  int? idCash;
  String? valor;
  String? data;
  String? categoria;
  String? descricao;
  Cash({
    this.idCash,
    this.valor,
    this.data,
    this.categoria,
    this.descricao,
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'idCash': idCash,
      'valor': valor,
      'data': data,
      'categoria': categoria,
      'descricao': descricao,
    };
  } 

  factory Cash.fromMap(Map<String, dynamic> map){
    return Cash(
      idCash: map['idCash'] != null ? map['idCash'] as int : null,
      valor: map['valor'] != null ? map['valor'] as String : null ,
      data: map['data'] != null ? map['data'] as String : null,
      categoria: map['categoria'] != null ? map['categoria'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }


  Cash copyWith({
    int? idCash,
    String? valor,
    String? data,
    String? categoria,
    String? descricao,
  }) {
    return Cash(
      idCash: idCash ?? this.idCash,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      categoria: categoria ?? this.categoria,
      descricao: descricao ?? this.descricao,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cash.fromJson(String source) => Cash.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cash(idCash: $idCash, valor: $valor, data: $data, categoria: $categoria, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant Cash other) {
    if (identical(this, other)) return true;
  
    return 
      other.idCash == idCash &&
      other.valor == valor &&
      other.data == data &&
      other.categoria == categoria &&
      other.descricao == descricao;
  }

  @override
  int get hashCode {
    return idCash.hashCode ^
      valor.hashCode ^
      data.hashCode ^
      categoria.hashCode ^
      descricao.hashCode;
  }
}
