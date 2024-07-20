import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/core/model/todomodel.dart';

final todoDatabaseServicesProvider = Provider((ref) => DatabaseServices());

class DatabaseServices {
  Database? _database;
  String tableName = "todoTable";

  Future<Database?> get getDatabase async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "todoDatabase.db");
    if (_database != null) {
      return _database;
    }

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(''' CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          time TEXT
          )
    ''');
      },
    );
    return _database;
  }

  Future<List<Todomodel>> getTodoData() async {
    Database? db = await getDatabase;
    final data = await db!.query(tableName);
    final result = data.map((e) => Todomodel.fromMap(e)).toList();

    return result;
  }

  Future<int> insertTodo(Todomodel todoModel) async {
    Database? db = await getDatabase;
    Todomodel todoData = Todomodel(
      title: todoModel.title,
      description: todoModel.description,
      time: DateTime.now().toString(),
    );

    final result = await db!.insert(
      tableName,
      todoData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await getTodoData();
    return result;
  }

  deleteTodo(String id) async {
    Database? db = await getDatabase;
    await db!.delete(tableName, where: "id = ?", whereArgs: [id]);
    await getTodoData();
  }

  updateTodo(String id, Todomodel todo) async {
    Database? db = await getDatabase;
    await db!.update(tableName, todo.toMap(), where: "id = ?", whereArgs: [id]);
    await getTodoData();
  }
}
