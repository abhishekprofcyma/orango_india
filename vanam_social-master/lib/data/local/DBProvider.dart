import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model/CartModel.dart';

class DBProvider {
   DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 3, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
              "id INTEGER PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "blocked BIT"
              ")");

          await db.execute("CREATE TABLE Categorys ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "image TEXT"
              ")");

          await db.execute("CREATE TABLE Cart ("
              "id INTEGER PRIMARY KEY,"
              "pro_id INTEGER ,"
              "name TEXT,"
              "quantity INTEGER"
              ")");

          await db.execute("CREATE TABLE recent_search ("
              "id INTEGER PRIMARY KEY,"
              "keyword TEXT ,"
              "time TEXT"
              ")");

        },
      onUpgrade: (Database db,int version,int latest)async{
        if(version == 2){
          await db.execute("CREATE TABLE recent_search ("
              "id INTEGER PRIMARY KEY,"
              "keyword TEXT ,"
              "time TEXT"
              ")");
        }
      }
    );
  }


}
