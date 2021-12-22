import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_model.dart';
import 'components/todo_list.dart';
import 'components/create_todo.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoModel(), child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Todo'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TodoList(),
      floatingActionButton: const CreateTodo(),
    );
  }
}
