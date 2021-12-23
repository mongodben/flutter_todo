class Todo {
  String id;
  String name;
  TodoStatus status;

  Todo({required this.id, required this.name, this.status = TodoStatus.todo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status.val,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, status: ${status.val}}';
  }
}

enum TodoStatus { todo, doing, done }

extension ParseToString on TodoStatus {
  get val {
    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}

TodoStatus getTodoStatus(String statusStr) {
  switch (statusStr) {
    case 'todo':
      return TodoStatus.todo;
    case 'doing':
      return TodoStatus.doing;
    case 'done':
      return TodoStatus.done;
    default:
      return TodoStatus.todo;
  }
}
