// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LancamentoCriacaoDto {

String? valor;
  String? data;
  String? tipo;
  String? descricao;
  LancamentoCriacaoDto({
    this.valor,
    this.data,
    this.tipo,
    this.descricao,
  });


  LancamentoCriacaoDto copyWith({
    String? valor,
    String? data,
    String? tipo,
    String? descricao,
  }) {
    return LancamentoCriacaoDto(
      valor: valor ?? this.valor,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valor': valor,
      'data': data,
      'tipo': tipo,
      'descricao': descricao,
    };
  }

  factory LancamentoCriacaoDto.fromMap(Map<String, dynamic> map) {
    return LancamentoCriacaoDto(
      valor: map['valor'] != null ? map['valor'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LancamentoCriacaoDto.fromJson(String source) => LancamentoCriacaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LancamentoCriacaoDto(valor: $valor, data: $data, tipo: $tipo, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant LancamentoCriacaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.valor == valor &&
      other.data == data &&
      other.tipo == tipo &&
      other.descricao == descricao;
  }

  @override
  int get hashCode {
    return valor.hashCode ^
      data.hashCode ^
      tipo.hashCode ^
      descricao.hashCode;
  }
}
