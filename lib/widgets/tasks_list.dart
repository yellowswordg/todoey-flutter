import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoey_flutter/providers/tasks_provider.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

class TasksList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final state = watch(tasksProvider.state);

    return state.isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return TaskTile(
                taskTitle: task.task,
                isChecked: task.isDone,
                checkboxCallback: (_) {
                  context.read(tasksProvider).update(task.id);
                },
                longPressCallback: () {
                  context.read(tasksProvider).delete(task.id);
                },
              );
            },
            // itemCount: state.tasks.length,
            itemCount: state.tasks.length,
          );
  }
}

// return BlocBuilder<TodosBloc, TodosState>(
//       builder: (context, state) {
//         if (state is TodosLoading) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is TodosLoadSuccess) {
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               // print(state.tasks[index].task);
//               return TaskTile(
//                 taskTitle: state.tasks[index].task,
//                 isChecked: state.tasks[index].isDone,
//                 checkboxCallback: (_) {
//                   context.bloc<TodosBloc>().add(TodosUpdate(
//                       task: state.tasks[index]
//                           .copyWith(isDone: !state.tasks[index].isDone)));
//                 },
//                 longPressCallback: () {
//                   context
//                       .bloc<TodosBloc>()
//                       .add(TodosDelete(id: state.tasks[index].id));
//                 },
//               );
//             },
//             itemCount: state.tasks.length,
//           );
//         }
//       },
//     );
