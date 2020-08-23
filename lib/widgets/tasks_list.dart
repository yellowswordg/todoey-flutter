import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_flutter/bloc/todos_bloc.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodosLoadSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TaskTile(
                taskTitle: state.tasks[index].task,
                isChecked: state.tasks[index].isDone,
                // checkboxCallback: (checkboxState) {
                //   taskData.updateTask(task);
                // },
                longPressCallback: () {
                  context
                      .bloc<TodosBloc>()
                      .add(TodosDelete(id: state.tasks[index].id));
                },
              );
            },
            itemCount: state.tasks.length,
          );
        }
      },
    );
  }
}
