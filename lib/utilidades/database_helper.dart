import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reclutamiento/datos/pokemons.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Database? _db;

  Future<Database?> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "pokemons.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Pokemon(id INTEGER PRIMARY KEY, name TEXT, weight TEXT, abilities TEXT, game_indices TEXT , species TEXT, back_default BLOB, front_default BLOB, like TEXT)");
    print("Created tables");
  }

  Future<int> savePokemon(Pokemons pokemon) async {
    var dbClient = await db;
    int res = await dbClient!.insert("Pokemon", pokemon.toMap());
    return res;
  }

  Future<int> deletePokemon() async {
    var dbClient = await db;
    int res = await dbClient!.delete("Pokemon");
    return res;
  }

  Future<int> upadatePokemon(Pokemons pokemon) async{
    var dbClient = await db;
    int res = await dbClient!.update("Pokemon", pokemon.toMap());
    return res;
  }

}