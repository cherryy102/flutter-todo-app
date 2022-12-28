import 'package:flutter/material.dart';
import 'package:sqlite_todo_app/models/ToDo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final Function onDeleteItem;
  final Function onCheck;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDeleteItem,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        onDismissed: (direction) {
          onDeleteItem(todo);
        },
        direction: DismissDirection.endToStart,
        key: Key(todo.id.toString()),
        background: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(right: 10),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          padding: const EdgeInsets.only(right: 10),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        child: ListTile(
          onTap: () {
            onCheck(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: const Color(0xFF5F52EE),
          ),
          title: Text(
            todo.text ?? '',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
