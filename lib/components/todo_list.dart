import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todo.dart';
import '../todo_model.dart';
import 'modify_todo.dart';

List<Todo> _todoListGenerator(int amountToGenerate) {
  List<Todo> todos = [];
  for (var i = 0; i < amountToGenerate; i++) {
    todos.add(Todo(id: '$i', name: 'My Todo $i'));
  }

  return todos;
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, todosModel, child) {
        final todos = todosModel.todos;
        return SizedBox(
          height: double.infinity,
          child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, i) {
                final todo = todos[i];
                return _SingleTodoView(todo);
              }),
        );
      },
    );
  }
}

class _SingleTodoView extends StatelessWidget {
  final Todo todo;

  const _SingleTodoView(this.todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.name),
        subtitle: Text(todo.status.val),
        trailing: ModifyTodoButton(todo),
      ),
    );
  }
}

// Form(
//   key: _formKey,
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Padding(
//         padding: EdgeInsets.all(8.0),
//         child: TextFormField(),
//       ),
//       Padding(
//         padding: EdgeInsets.all(8.0),
//         child: TextFormField(),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: RaisedButton(
//           child: Text("Submit"),
//           onPressed: () {
//             if (true) {
//               print('ok');
//             }
//           },
//         ),
//       )
//     ],
//   ),
// ),
