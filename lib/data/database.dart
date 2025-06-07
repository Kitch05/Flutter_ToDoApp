import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  void initializeDatabase() {
    toDoList = [
      ['Welcome!', true],
      ['Add a new task!', false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updatedDB() {
    _myBox.put('TODOLIST', toDoList);
  }
}
