import 'package:flutter/material.dart';
import './todo.dart';

List<Todo> _todoListGenerator(int amountToGenerate) {
  List<Todo> todos = [];
  for (var i = 0; i < amountToGenerate; i++) {
    todos.add(Todo(id: i, name: 'My Todo $i'));
  }

  return todos;
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _myTodos = _todoListGenerator(80);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView.builder(
          itemCount: _myTodos.length,
          itemBuilder: (_, i) {
            final todo = _myTodos[i];
            return _TodoView(todo.name, todo.status);
          }),
    );
  }
}

class _TodoView extends StatefulWidget {
  final String name;
  final TodoStatus status;

  const _TodoView(this.name, this.status, {Key? key}) : super(key: key);

  @override
  __TodoViewState createState() => __TodoViewState();
}

class __TodoViewState extends State<_TodoView> {
  final _formKey = GlobalKey<FormState>();
  var _modalOpen = false;

  void setModalOpen(bool modalState) {
    setState(() {
      _modalOpen = modalState;
    });
    // TODO: return to this when i better understand how to handle dialog
    // has to do w Navigator context smthn
    // ref: https://stackoverflow.com/questions/50683524/how-to-dismiss-flutter-dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if (true) {
                            print('ok');
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name),
        subtitle: Text(widget.status.val),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () => setModalOpen(true)),
      ),
    );
  }
}
