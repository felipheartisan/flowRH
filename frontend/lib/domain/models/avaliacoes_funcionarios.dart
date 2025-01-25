class Avaliacao {
  int? idAvaliacoes;
  String? nota;
  String? cursosFeitos;
  String? cursosInteresse;
  String? atividades;
  String? mesReferencia;
  String? anoReferencia;
  int? IdFuncionarios;
  // ignore: non_constant_identifier_names
  String? NomeFuncionario;

  Avaliacao({
    this.idAvaliacoes,
    this.nota,
    this.cursosFeitos,
    this.cursosInteresse,
    this.atividades,
    this.mesReferencia,
    this.anoReferencia,
    this.IdFuncionarios,
    this.NomeFuncionario,
  });

  // Convertir um objeto Avaliacao em um Map
  Map<String, dynamic> toMap() {
    return {
      'idAvaliacoes': idAvaliacoes,
      'nota': nota,
      'cursos_feitos': cursosFeitos,
      'cursos_interesse': cursosInteresse,
      'atividades': atividades,
      'mes_referencia': mesReferencia,
      'ano_referencia': anoReferencia,
      'idFuncionarios': IdFuncionarios,
      

    };
  }

  // Convertir um Map em um objeto Avaliacao
  factory Avaliacao.fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      idAvaliacoes: map['idAvaliacoes'],
      nota: map['nota'],
      cursosFeitos: map['cursos_feitos'],
      cursosInteresse: map['cursos_interesse'],
      atividades: map['atividades'],
      mesReferencia: map['mes_referencia'],
      anoReferencia: map['ano_referencia'],
      IdFuncionarios: map['idFuncionarios'],
      NomeFuncionario: map['NomeFuncionario'],
    );
  }
}