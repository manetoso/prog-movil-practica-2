class MovieTableModel {
  int? id;
  String? title;
  String? overview;
  String? posterPath;
  String? idMovie;

  /*NotasModel(int id, String titulo, String detalle) {
    this.id = id;
    this.titulo = titulo;
    this.detalle = detalle;
  }*/

  MovieTableModel({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.idMovie
  });

  //Map -> Object
  factory MovieTableModel.fromMap(Map<String, dynamic> map) {
    return MovieTableModel(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['posterPath'],
      idMovie: map['idMovie'],
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'overview': overview, 'posterPath': posterPath, 'idMovie': idMovie};
  }
}
