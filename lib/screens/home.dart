import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqlite_todo_app/data/database.dart';
import 'package:sqlite_todo_app/widgets/todo_item.dart';
import '../models/ToDo.dart';
import '../widgets/dialog_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _myBox = Hive.box('tasks');
  ToDoDataBase db = ToDoDataBase();
  final _todoController = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('ToDoList') == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (ToDo todo in db.toDoList)
                        TodoItem(
                          todo: todo,
                          onDeleteItem: onDeleteItem,
                          onCheck: _onCheck,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    child: FloatingActionButton(
                      tooltip: 'Clear all',
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _onDelete();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: FloatingActionButton(
                      tooltip: 'Add',
                      backgroundColor: const Color(0xFF5F52EE),
                      onPressed: () {
                        createTask();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 40,
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (builder) {
          return DialogBox(
            controller: _todoController,
            onCancel: () => Navigator.of(context).pop(),
            onSave: _onAddItem,
          );
        });
  }

  void _onDelete() {
    setState(() {
      db.toDoList.clear();
      db.updateData();
    });
  }

  void onDeleteItem(ToDo toDo) {
    setState(() {
      db.toDoList.removeWhere((element) => element.id == toDo.id);
      db.updateData();
    });
  }

  void _onCheck(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
      db.toDoList.sort((a, b) {
        if (b.isDone) {
          return -1;
        }
        return 1;
      });
      db.updateData();
    });
  }

  void _onAddItem() {
    setState(() {
      if (_todoController.text != '') {
        db.toDoList.add(ToDo(
            id: DateTime.now().millisecond,
            text: _todoController.text,
            isDone: false));
        db.updateData();
      }
    });
    _todoController.clear();
  }
}
