import 'package:flutter/material.dart';
import 'package:practica_2/src/database/database_helper.dart';
import 'package:practica_2/src/models/movie_table_model.dart';

class MovieListProvider extends ChangeNotifier {
  List<MovieTableModel?> movies = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  insertNewMovie(String title, String overview, String posterPath, String idMovie,) async {
    MovieTableModel newMovie = MovieTableModel(
      title: title,
      overview: overview,
      posterPath: posterPath,
      idMovie: idMovie
    );
    await _databaseHelper.insertMovie(newMovie.toMap());

    notifyListeners();
  }

  loadMovies() async {
    final movies = await _databaseHelper.getAllMovies();
    this.movies = [...movies];
    notifyListeners();
  }

  deleteMovie(String id) async{
    await _databaseHelper.deleteMovie(id);
    this.movies.removeWhere((actualMovie) => actualMovie!.idMovie == id);
    notifyListeners();
  }
}