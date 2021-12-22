class Todo {
  String id;
  String name;
  TodoStatus status;

  Todo({required this.id, required this.name, this.status = TodoStatus.todo});
}

enum TodoStatus { todo, doing, done }
extension ParseToString on TodoStatus {
  get val {
    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}
