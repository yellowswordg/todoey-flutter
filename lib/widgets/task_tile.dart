import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;
  final Function onTap;

  TaskTile({
    this.isChecked,
    this.taskTitle,
    this.checkboxCallback,
    this.longPressCallback,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // print(isChecked);
    return ListTile(
      onTap: onTap,
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(decoration: TextDecoration.none),
        // decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      // trailing: Checkbox(
      //   activeColor: Colors.lightBlueAccent,
      //   value: isChecked,
      //   onChanged: checkboxCallback,
      // ),
    );
  }
}
