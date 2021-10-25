import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica_2/src/models/movie_table_model.dart';
import 'package:practica_2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblNotas";
  static final _nombreMoviesTBL = "tblMovies";

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return openDatabase(rutaDB, version: _versionBD, onCreate: _crearTabla);
  }

  Future<void> _crearTabla(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_nombreTBL (
        id INTEGER PRIMARY KEY,
        titulo VARCHAR(50),
        detalle VARCHAR(100)
      )
    ''');
    await db.execute('''
      CREATE TABLE $_nombreMoviesTBL (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        overview TEXT NOT NULL,
        posterPath TEXT NOT NULL,
        idMovie TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> insertMovie(Map<String, dynamic> row) async {
    var conexion = await database;
    var res = await conexion!.insert(_nombreMoviesTBL, row);
    return res;
  }
  Future<List<MovieTableModel>> getAllMovies() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreMoviesTBL);
    return result.map((moviesMap) => MovieTableModel.fromMap(moviesMap)).toList();
  }
  recognizeMovie(String movieId) async {
    var conexion = await database;
    var result = await conexion!.rawQuery('''
      SELECT idMovie FROM $_nombreMoviesTBL
      WHERE idMovie = '$movieId'
    ''');
    if (result.toString().length > 2) {
      return true;
    } else {
      return false;
    }
  }
  Future<int> deleteMovie(String id) async {
    var conexion = await database;
    var res = await conexion!.rawDelete('''
      DELETE FROM $_nombreMoviesTBL
      WHERE idMovie = '$id'
    ''');
    return res;
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notasMap) => NotasModel.fromMap(notasMap)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id = ?', whereArgs: [id]);
    return NotasModel.fromMap(result.first);
  }
}
