class PublicacaoModel {
  int? id;
  String nome;
  String sigla;
  int tipoId;
  String excelRow;
  int quantidade;
  PublicacaoModel({
    this.id,
    required this.nome,
    required this.sigla,
    required this.tipoId,
    required this.excelRow,
    required this.quantidade,
  });

  factory PublicacaoModel.fromMap(Map<String, dynamic> map) {
    return PublicacaoModel(
      id: map['id'],
      nome: map['nome'],
      sigla: map['sigla'],
      tipoId: map['tipoId'],
      excelRow: map['excelRow'],
      quantidade: map['quantidade'],
    );
  }
}
