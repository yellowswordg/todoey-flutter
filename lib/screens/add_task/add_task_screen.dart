import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:todoey_flutter/providers/tasks_provider.dart';

class AddTaskScreen extends ConsumerWidget {
  final String taskText;
  final bool isEditing;

  AddTaskScreen({this.isEditing = false, this.taskText = ''});

  @override
  Widget build(BuildContext context, read) {
    final textField = read(textFieldProvider).state;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextFormField(
              initialValue: isEditing ? textField : '',
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                context.read(textFieldProvider).state = newText;
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                context.read(tasksProvider).add(textField);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
