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
  TodoStatus? _status = TodoStatus.doing;

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;

    return Consumer<TodoModel>(
      builder: (context, todosModel, child) {
        final todoEditingController =
            TextEditingController(text: widget.todo.name);

        void _update() {
          print('updating with ${_status?.val}');
          todosModel.update(
            id: widget.todo.id,
            name: todoEditingController.text,
            status: _status,
          );
        }

        void _deleteTodo() {
          todosModel.delete(widget.todo.id);
        }

        void handleTodoRadioChange(TodoStatus? value) {
          print('changed value is $value');
          setState(() {
            _status = value;
          });
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Column(
                      children: <Widget>[
                        RadioListTile(
                          title: Text(TodoStatus.todo.val),
                          value: TodoStatus.todo,
                          onChanged: handleTodoRadioChange,
                          groupValue: _status,
                        ),
                        RadioListTile(
                          title: Text(TodoStatus.doing.val),
                          value: TodoStatus.doing,
                          onChanged: handleTodoRadioChange,
                          groupValue: _status,
                        ),
                        RadioListTile(
                          title: Text(TodoStatus.done.val),
                          value: TodoStatus.done,
                          onChanged: handleTodoRadioChange,
                          groupValue: _status,
                        ),
                      ],
                    ),
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
