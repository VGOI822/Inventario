class TipoModel {
  int? id;
  String tipo;
  TipoModel({
    this.id,
    required this.tipo,
  });

  factory TipoModel.fromMap(Map<String, dynamic> map) {
    return TipoModel(
      id: map['id'],
      tipo: map['tipo'],
    );
  }
}
