import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/Models/ToDoModels/To_Do_Models.dart';

const toDoDBName = "TODODBVIPIN";

abstract class TodoDBFunctions {
  Future<void> incertToFunction(TodoModel todo);
  Future<List<TodoModel>> getTodoFunction();
  Future<void> deleteTodo(String id);
  Future<void> updateStatusToCompete(TodoModel todo);
  Future<void> updateStatusToUncomplete(TodoModel todo);
}

class TodoDB extends TodoDBFunctions {
  ValueNotifier<List<TodoModel>> uncompletedTodosNotifier = ValueNotifier([]);
  ValueNotifier<List<TodoModel>> completedTodosNotifier = ValueNotifier([]);

  TodoDB._internal();
  static TodoDB instance = TodoDB._internal();
  factory TodoDB() {
    return instance;
  }
  @override
  Future<void> deleteTodo(id) async {
    final _todoDB = await Hive.openBox<TodoModel>(toDoDBName);

    await _todoDB.delete(id);
  }

  @override
  Future<List<TodoModel>> getTodoFunction() async {
    final _todoDB = await Hive.openBox<TodoModel>(toDoDBName);
    return _todoDB.values.toList();
  }

  @override
  Future<void> incertToFunction(TodoModel todo) async {
    final _todoDB = await Hive.openBox<TodoModel>(toDoDBName);
    await _todoDB.put(todo.id, todo);
    reFreshUi();
  }

  Future<void> reFreshUi() async {
    final _allTodoes = await getTodoFunction();
    uncompletedTodosNotifier.value.clear();
    completedTodosNotifier.value.clear();
    final nList = _allTodoes.reversed;

    await Future.forEach(nList, (TodoModel todo) async {
      if (todo.isCompleted == true && todo.isDeleted == false) {
        completedTodosNotifier.value.add(todo);
      } else if (todo.isCompleted == false && todo.isDeleted == false) {
        uncompletedTodosNotifier.value.add(todo);
      }
    });
    completedTodosNotifier.notifyListeners();
    uncompletedTodosNotifier.notifyListeners();
  }

  @override
  Future<void> updateStatusToCompete(TodoModel todo) async {
    final _todoDB = await Hive.openBox<TodoModel>(toDoDBName);
    final TodoModel? targetModel = _todoDB.get(todo.id);
    if (targetModel == null) {
      return;
    }
    final newModel = TodoModel(
      id: targetModel.id,
      todo: targetModel.todo,
      isCompleted: true,
    );
    await _todoDB.delete(todo.id);
    await incertToFunction(newModel);
  }

  @override
  Future<void> updateStatusToUncomplete(TodoModel todo) async {
    final _todoDB = await Hive.openBox<TodoModel>(toDoDBName);
    final TodoModel? targetModel = _todoDB.get(todo.id);
    if (targetModel == null) {
      return;
    }
    final newModel = TodoModel(
      id: targetModel.id,
      todo: targetModel.todo,
      isCompleted: false,
    );
    await _todoDB.delete(todo.id);
    await incertToFunction(newModel);
  }
}
