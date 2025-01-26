// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AvaliacaoEdicaoDto {
  int? id;
  String? nota;
  String? cursosFeitos;
  String? cursosFazer;
  String? atividades;
  String? mesReferencia;
  String? anoReferencia;
  int? idFuncionario;
  AvaliacaoEdicaoDto({
    this.id,
    this.nota,
    this.cursosFeitos,
    this.cursosFazer,
    this.atividades,
    this.mesReferencia,
    this.anoReferencia,
    this.idFuncionario,
  });



  AvaliacaoEdicaoDto copyWith({
    int? id,
    String? nota,
    String? cursosFeitos,
    String? cursosFazer,
    String? atividades,
    String? mesReferencia,
    String? anoReferencia,
    int? idFuncionario,
  }) {
    return AvaliacaoEdicaoDto(
      id: id ?? this.id,
      nota: nota ?? this.nota,
      cursosFeitos: cursosFeitos ?? this.cursosFeitos,
      cursosFazer: cursosFazer ?? this.cursosFazer,
      atividades: atividades ?? this.atividades,
      mesReferencia: mesReferencia ?? this.mesReferencia,
      anoReferencia: anoReferencia ?? this.anoReferencia,
      idFuncionario: idFuncionario ?? this.idFuncionario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nota': nota,
      'cursosFeitos': cursosFeitos,
      'cursosFazer': cursosFazer,
      'atividades': atividades,
      'mesReferencia': mesReferencia,
      'anoReferencia': anoReferencia,
      'idFuncionario': idFuncionario,
    };
  }

  factory AvaliacaoEdicaoDto.fromMap(Map<String, dynamic> map) {
    return AvaliacaoEdicaoDto(
      id: map['id'] != null ? map['id'] as int : null,
      nota: map['nota'] != null ? map['nota'] as String : null,
      cursosFeitos: map['cursosFeitos'] != null ? map['cursosFeitos'] as String : null,
      cursosFazer: map['cursosFazer'] != null ? map['cursosFazer'] as String : null,
      atividades: map['atividades'] != null ? map['atividades'] as String : null,
      mesReferencia: map['mesReferencia'] != null ? map['mesReferencia'] as String : null,
      anoReferencia: map['anoReferencia'] != null ? map['anoReferencia'] as String : null,
      idFuncionario: map['idFuncionario'] != null ? map['idFuncionario'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvaliacaoEdicaoDto.fromJson(String source) => AvaliacaoEdicaoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AvaliacaoEdicaoDto(id: $id, nota: $nota, cursosFeitos: $cursosFeitos, cursosFazer: $cursosFazer, atividades: $atividades, mesReferencia: $mesReferencia, anoReferencia: $anoReferencia, idFuncionario: $idFuncionario)';
  }

  @override
  bool operator ==(covariant AvaliacaoEdicaoDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nota == nota &&
      other.cursosFeitos == cursosFeitos &&
      other.cursosFazer == cursosFazer &&
      other.atividades == atividades &&
      other.mesReferencia == mesReferencia &&
      other.anoReferencia == anoReferencia &&
      other.idFuncionario == idFuncionario;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nota.hashCode ^
      cursosFeitos.hashCode ^
      cursosFazer.hashCode ^
      atividades.hashCode ^
      mesReferencia.hashCode ^
      anoReferencia.hashCode ^
      idFuncionario.hashCode;
  }
}
