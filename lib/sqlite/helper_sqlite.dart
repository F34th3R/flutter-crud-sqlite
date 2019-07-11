import 'dart:async';
import 'dart:io' as io;
import 'package:crud_sqlite/migrations/EmployeeMigration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'employee1.db';
  EmployeeMigration _employeeMigration = EmployeeMigration();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    _employeeMigration.onCreate(db, version);
  }
}
