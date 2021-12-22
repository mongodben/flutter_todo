import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todo_model.dart';

class CreateTodo extends StatelessWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, todosModel, child) {

        void handlePressed() {
          // TODO: make the ModalBottomSheet go up with keyboard
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const CreateTodoForm();
            },
          );
        }

        return FloatingActionButton(
          onPressed: handlePressed,
          tooltip: 'Add',
          child: const Icon(Icons.add),
        );
      },
    );
  }
}

class CreateTodoForm extends StatefulWidget {
  const CreateTodoForm({Key? key}) : super(key: key);

  @override
  _CreateTodoFormState createState() => _CreateTodoFormState();
}

class _CreateTodoFormState extends State<CreateTodoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, todosModel, child) {
        final todoEditingController = TextEditingController();
        void _addTodo(String todoName) {
          todosModel.create(todoName);
        }
        return Container(
          height: 200,
          color: Colors.grey.shade100,
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Create a New Todo'),
                TextFormField(
                  controller: todoEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addTodo(todoEditingController.text);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
