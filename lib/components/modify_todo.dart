import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todo_model.dart';
import '../todo.dart';

class ModifyTodoButton extends StatelessWidget {
  final Todo todo;
  const ModifyTodoButton(this.todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handlePressed() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ModiftyTodoForm(todo);
        },
      );
    }

    return IconButton(icon: const Icon(Icons.edit), onPressed: handlePressed);
  }
}

class ModiftyTodoForm extends StatefulWidget {
  final Todo todo;
  const ModiftyTodoForm(this.todo, {Key? key}) : super(key: key);

  @override
  _ModiftyTodoFormState createState() => _ModiftyTodoFormState();
}

class _ModiftyTodoFormState extends State<ModiftyTodoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;

    return Consumer<TodoModel>(
      builder: (context, todosModel, child) {
        final todoEditingController =
            TextEditingController(text: widget.todo.name);

        TodoStatus _status = widget.todo.status;
        void _update() {
          todosModel.update(widget.todo.id, name: todoEditingController.text);
        }

        void _deleteTodo() {
          todosModel.delete(widget.todo.id);
        }

        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.grey.shade100,
              height: 350,
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Center(
                  child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Update Your Todo',
                      style: myTextTheme.headline6,
                    ),
                    TextFormField(
                      controller: todoEditingController,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     ListTile(
                    //       title: Text(TodoStatus.todo.val),
                    //       leading: Radio<TodoStatus>(
                    //         value: TodoStatus.todo,
                    //         groupValue: _status,
                    //         onChanged: (TodoStatus? value) {
                    //           setState(() {
                    //             _status = TodoStatus.todo;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     ListTile(
                    //       title: Text(TodoStatus.doing.val),
                    //       leading: Radio<TodoStatus>(
                    //         value: TodoStatus.doing,
                    //         groupValue: _status,
                    //         onChanged: (TodoStatus? value) {
                    //           setState(() {
                    //             _status = TodoStatus.doing;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                                child: const Text('Cancel'),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                onPressed: () => Navigator.pop(context)),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                                child: const Text('Delete'),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  _deleteTodo();
                                  Navigator.pop(context);
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              child: const Text('Update'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _update();
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ));
      },
    );
  }
}
