import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  FocusNode myFocusNode = FocusNode();

  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.only(top: 25),
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              focusNode: myFocusNode,
              onSubmitted: (value) {
                onSave();
                myFocusNode.requestFocus();
              },
              autofocus: true,
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'New  task',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF5F52EE),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F52EE),
                  ),
                  onPressed: onSave,
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
