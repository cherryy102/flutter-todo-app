import 'package:hive/hive.dart';
import 'package:sqlite_todo_app/models/ToDo.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('tasks');

  void initialData() {
    toDoList = [];
  }

  void loadData() {
    toDoList = _myBox.get('ToDoList');
  }

  void updateData() {
    _myBox.put('ToDoList', toDoList);
  }
}
