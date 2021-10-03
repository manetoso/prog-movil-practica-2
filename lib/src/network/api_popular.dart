import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica_2/src/models/popular_movies_model.dart';

class ApiPopular {
  var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=e9ca31205c0080b081d82fd75e22922d&language=es-MX&page=1');
  Future<List<PopularMoviesModel>?> getAllPopular() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
    } else {
      return null;
    }
  }
}
