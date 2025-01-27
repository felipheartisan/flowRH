import 'package:flow_rh/domain/models/funcionarios.dart';

import 'funcionarios.dart';

class Avaliacao {
  int? id;
  String? nota;
  String? cursosFeitos;
  String? cursosInteresse;
  String? atividades;
  String? mesReferencia;
  String? anoReferencia;
  Funcionario? funcionario;
  String? NomeFuncionario;

  Avaliacao({
    this.id,
    this.nota,
    this.cursosFeitos,
    this.cursosInteresse,
    this.atividades,
    this.mesReferencia,
    this.anoReferencia,
    this.funcionario,
    this.NomeFuncionario,
  });

  // Convertir um objeto Avaliacao em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nota': nota,
      'cursosFeitos': cursosFeitos,
      'cursosInteresse': cursosInteresse,
      'atividades': atividades,
      'mesReferencia': mesReferencia,
      'anoReferencia': anoReferencia,
      'funcionario': funcionario,
      

    };
  }

  // Convertir um Map em um objeto Avaliacao
  factory Avaliacao.fromMap(Map<String, dynamic> map) {
  return Avaliacao(
    id: map['id'] as int?,
    nota: map['nota'] as String?,
    cursosFeitos: map['cursosFeitos'] as String?,
    cursosInteresse: map['cursosFazer'] as String?, // Corrigido conforme o JSON
    atividades: map['atividades'] as String?,
    mesReferencia: map['mesReferencia'] as String?,
    anoReferencia: map['anoReferencia'] as String?,
    funcionario: map['funcionario'] != null
        ? Funcionario.fromMap(map['funcionario'] as Map<String, dynamic>)
        : null,
    NomeFuncionario: map['funcionario']?['nome'] as String?,
     // Pega o nome diretamente do objeto funcionário
  );
}



}