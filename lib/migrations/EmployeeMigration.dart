import 'package:sqflite/sqflite.dart';

class EmployeeMigration {

  static const String _ID = 'id';
  static const String _NAME = 'name';
  static const String _TABLE = 'Employee';

  static String get id => _ID;
  static String get name => _NAME;
  static String get table => _TABLE;

  onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $_TABLE ($_ID INTEGER PRIMARY KEY, $_NAME TEXT)");
  }
}