import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initializeDb() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbPath = join(await getDatabasesPath(), 'todo_database.db');
  final database = await openDatabase(
    dbPath,
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE todos(dbid INTEGER PRIMARY KEY, id TEXT, name TEXT, status TEXT)',
      );
    },
    version: 1,
  );
  //await deleteDatabase(dbPath);
  //throw new Exception('bye bye');

  return database;
}
