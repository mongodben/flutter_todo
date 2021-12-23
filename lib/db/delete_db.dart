import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "todo_database.db");
  print(path);
  await deleteDatabase(path);
  print('deleted db successfully');
}
