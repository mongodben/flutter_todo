import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './todo.dart';

class TodoModel extends ChangeNotifier {
  final List<Todo> _todos = [];
  final _uuid = const Uuid();

  List<Todo> get todos => _todos;

  Todo create(String name) {
    final id = _uuid.v4();
    final newTodo = Todo(id: id, name: name);

    _todos.add(newTodo);

    notifyListeners();

    return newTodo;
  }

  Todo read(String id) {
    final todo = _todos.singleWhere((todo) => todo.id == id);

    notifyListeners();

    return todo;
  }

  Todo update({required String id, String? name, TodoStatus? status}) {
    if (name == null && status == null) {
      throw Exception(
          'You must include either a name, status, or both in Todo update.');
    }
    final todo = _todos.singleWhere((todo) => todo.id == id);
    if (name != null) {
      todo.name = name;
    }
    if (status != null) {
      todo.status = status;
    }

    notifyListeners();

    return todo;
  }

  bool delete(String id) {
    final lenBefore = _todos.length;
    _todos.removeWhere((todo) => todo.id == id);
    final lenAfter = _todos.length;

    notifyListeners();

    if (lenAfter == lenBefore - 1) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAll() {
    _todos.clear();

    notifyListeners();
  }
}
