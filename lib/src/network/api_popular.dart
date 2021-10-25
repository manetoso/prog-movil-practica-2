import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica_2/src/models/cast_model.dart';
import 'package:practica_2/src/models/movie_video_model.dart';
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
      return listPopular;
    } else {
      return null;
    }
  }
  
  test(String id) async {
    var URL2 = Uri.parse(
    'https://api.themoviedb.org/3/movie/$id/videos?api_key=e9ca31205c0080b081d82fd75e22922d&language=en-US'
    );
    final response = await http.get(URL);
    return response;
  }

  Future<List<CastModel>?> getCast(String id) async {
    var URLCast = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id/credits?api_key=e9ca31205c0080b081d82fd75e22922d&language=en-US'
    );
    final response = await http.get(URLCast);
    if (response.statusCode == 200) {
      var cast = jsonDecode(response.body)['cast'] as List;
      List<CastModel> listCast =
          cast.map((caster) => CastModel.fromMap(caster)).toList();
      return listCast;
    } else {
      return null;
    }
  }

  Future<List<MovieVideoModel>?> getMovieVideo(String id) async {
    var URL2 = Uri.parse(
    'https://api.themoviedb.org/3/movie/$id/videos?api_key=e9ca31205c0080b081d82fd75e22922d&language=en-US'
    );
    final response = await http.get(URL2);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<MovieVideoModel> listVideo =
          popular.map((movie) => MovieVideoModel.fromMap(movie)).toList();
      return listVideo;
    } else {
      return null;
    }
  }
}
