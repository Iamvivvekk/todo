import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/core/model/todomodel.dart';
import 'package:todo/services/database_services.dart';

final todoControllerProvider = Provider((ref) =>
    TodoController(databaseServices: ref.read(todoDatabaseServicesProvider)));

final todoDataProvider = FutureProvider.autoDispose((ref) async {
  return await ref.read(todoControllerProvider).getData();
});

class TodoController {
  final DatabaseServices _databaseServices;
  TodoController({required DatabaseServices databaseServices})
      : _databaseServices = databaseServices;

  Future<List<Todomodel>> getData() async {
    return await _databaseServices.getTodoData();
  }

  Future<void> insertTodo(Todomodel todo) async {
    await _databaseServices.insertTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _databaseServices.deleteTodo(id);
  }

  Future<void> update(String id, Todomodel todo) async {
    await _databaseServices.updateTodo(id, todo);
  }
}
