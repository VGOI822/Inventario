class LinguaModel {
  int? id;
  String lingua;

  LinguaModel({
    this.id,
    required this.lingua,
  });

  factory LinguaModel.fromMap(Map<String, dynamic> map) {
    return LinguaModel(
      id: map['id'],
      lingua: map['lingua'],
    );
  }
}
