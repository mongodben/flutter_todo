import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import './todo.dart';
import './db/db.dart';
import './db/todo.dart';

class TodoModel extends ChangeNotifier {
  final TodoDb todoDb;
  final List<Todo> todos;

  TodoModel({required this.todoDb, this.todos = const []});

  final _uuid = const Uuid();

  Todo create(String name) {
    final id = _uuid.v4();
    final newTodo = Todo(id: id, name: name);

    todos.add(newTodo);
    todoDb.insert(newTodo);

    notifyListeners();

    return newTodo;
  }

  Todo read(String id) {
    final todo = todos.singleWhere((todo) => todo.id == id);
    // TODO: add DB method for this
    notifyListeners();

    return todo;
  }

  Todo update({required String id, String? name, TodoStatus? status}) {
    if (name == null && status == null) {
      throw Exception(
          'You must include either a name, status, or both in Todo update.');
    }
    final todo = todos.singleWhere((todo) => todo.id == id);
    if (name != null) {
      todo.name = name;
    }
    if (status != null) {
      todo.status = status;
    }
    todoDb.update(todo);

    notifyListeners();

    return todo;
  }

  bool delete(String id) {
    final lenBefore = todos.length;
    todos.removeWhere((todo) => todo.id == id);
    final lenAfter = todos.length;
    todoDb.delete(id);

    notifyListeners();

    if (lenAfter == lenBefore - 1) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAll() {
    todos.clear();
    // TODO: create db method here
    notifyListeners();
  }
}
