import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_flutter/screens/task/tasks_screen.dart';
import 'package:todoey_flutter/models/task_repository.dart';

import 'bloc/todos_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TodosBloc(taskRepository: TaskRepository())..add(TodosLoaded()),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
