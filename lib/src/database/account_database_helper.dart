import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica_2/src/models/account_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountDatabaseHelper {
  static final _dbName = "DB-ACCOUNT";
  static final _dbVersion = 1;
  static final _tblName = "TBLaccount";
  static Database? _database;

  Future<void> _createTable(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tblName (id INTEGER PRIMARY KEY, name VARCHAR(100), last_name_1 VARCHAR(50), last_name_2 VARCHAR(50), phone_number VARCHAR(10), email VARCHAR(100), avatar VARCHAR(250))');
    await db.execute(
        'INSERT INTO $_tblName (id, name, last_name_1, last_name_2, phone_number, email, avatar) VALUES (1, "Nombre", "Apellido-1", "Apellido-2", "461", "correo@mail.com", "ruta/fregona.jpg")');
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String dbRoute = join(folder.path, _dbName);
    return openDatabase(dbRoute, version: _dbVersion, onCreate: _createTable);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_tblName, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<List<AccountModel>> getAllAccounts() async {
    var conexion = await database;
    var result = await conexion!.query(_tblName);
    return result
        .map((accountInfoMap) => AccountModel.fromMap(accountInfoMap))
        .toList();
  }

  Future<AccountModel> getAccount(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_tblName, where: 'id = ?', whereArgs: [id]);
    return AccountModel.fromMap(result.first);
  }
}
