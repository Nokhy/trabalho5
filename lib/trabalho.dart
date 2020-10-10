class Trabalho {
  String id;
  String descricao;
  int cargaHoraria;
  String materia;

  Trabalho(this.descricao, this.cargaHoraria, this.materia, {this.id});

  Map<String, dynamic> toMap() => {
        "descricao": descricao,
        "cargaHoraria": cargaHoraria,
        "materia": materia,
      };

  Trabalho.fromJson(Map<String, dynamic> json, String id_firebase)
      : descricao = json["descricao"],
        cargaHoraria = json["cargaHoraria"],
        materia = json["materia"],
        id = id_firebase;

  @override
  String toString() {
    return "Curso: $descricao \n Carga Horária: $cargaHoraria \n modalidade: $materia";
  }
}
