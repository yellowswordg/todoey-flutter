import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:todoey_flutter/providers/tasks_provider.dart';
import 'package:todoey_flutter/screens/add_task/add_task_screen.dart';

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
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen(
                        isEditing: true,
                        taskText: taskTitle,
                      ),
                    ),
                  ),
                );
              }),
          Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: isChecked,
            onChanged: checkboxCallback,
          ),
        ],
      ),
    );
  }
}
