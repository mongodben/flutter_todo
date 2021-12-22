import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './todo.dart';

class TodoModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Todo> _todos = [];
  final _uuid = const Uuid();

  /// An unmodifiable view of the items in the cart.
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
    if (name != null) {
      todo.name = name;
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
