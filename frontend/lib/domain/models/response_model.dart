import 'dart:convert';

class ResponseModel<T> {
  List<T>? dados;
  bool? status;
  String? mensagem;

  ResponseModel({
    this.dados,
    this.status,
    this.mensagem,
  });

  ResponseModel<T> copyWith({
    List<T>? dados,
    bool? status,
    String? mensagem,
  }) {
    return ResponseModel<T>(
      dados: dados ?? this.dados,
      status: status ?? this.status,
      mensagem: mensagem ?? this.mensagem,
    );
  }

  Map<String, dynamic> toMap(Function(T) toMapCallback) {
    return <String, dynamic>{
      'dados': dados?.map((x) => toMapCallback(x)).toList(),
      'status': status,
      'mensagem': mensagem,
    };
  }

factory ResponseModel.fromMap(
  Map<String, dynamic> map,
  T Function(Map<String, dynamic>) fromMapCallback,
) {
  // Verifique o tipo de "dados"
  final dados = map['dados'];

  return ResponseModel<T>(
    dados: dados != null
        ? (dados is List
            ? List<T>.from(
                dados.map((x) => fromMapCallback(x as Map<String, dynamic>)),
              )
            : [fromMapCallback(dados as Map<String, dynamic>)]) // Trata o caso em que "dados" é um mapa
        : null,
    status: map['status'] != null
        ? (map['status'] is int ? map['status'] == 1 : map['status'] as bool)
        : null,
    mensagem: map['mensagem'] != null ? map['mensagem'] as String : null,
  );
}




  String toJson(Function(T) toMapCallback) => json.encode(toMap(toMapCallback));

  factory ResponseModel.fromJson(
    String source,
    T Function(Map<String, dynamic>) fromMapCallback,
  ) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>, fromMapCallback);

  @override
  String toString() => 'ResponseModel(dados: $dados, status: $status, mensagem: $mensagem)';

  @override
  bool operator ==(covariant ResponseModel<T> other) {
    if (identical(this, other)) return true;

    return 
      _listEquals(other.dados, dados) &&
      other.status == status &&
      other.mensagem == mensagem;
  }

  @override
  int get hashCode => dados.hashCode ^ status.hashCode ^ mensagem.hashCode;

  // Helper function for list equality
  bool _listEquals(List? a, List? b) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
