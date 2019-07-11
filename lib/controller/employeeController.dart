import 'dart:async';
import 'package:crud_sqlite/migrations/EmployeeMigration.dart';
import 'package:crud_sqlite/model/employee.dart';
import 'package:crud_sqlite/sqlite/helper_sqlite.dart';

class EmployeeController extends DBHelper {

  Future<Employee> save(Employee employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(EmployeeMigration.table, employee.toMap());
    return employee;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(EmployeeMigration.table, columns: [EmployeeMigration.id, EmployeeMigration.name]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Employee> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Employee.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(EmployeeMigration.table, where: '${EmployeeMigration.id} = ?', whereArgs: [id]);
  }

  Future<int> update(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(EmployeeMigration.table, employee.toMap(),
        where: '${EmployeeMigration.id} = ?', whereArgs: [employee.id]);
  }

  Future<int> exist(String name) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT ${EmployeeMigration.id} FROM ${EmployeeMigration.table} WHERE ${EmployeeMigration.name} LIKE '" + name + "' LIMIT 1");
    print(result);
    return result.length;
  }
}