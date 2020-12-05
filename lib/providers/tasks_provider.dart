import 'package:flutter_riverpod/all.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/repositories/task_repository/task_repository.dart';

part 'tasks_provider.freezed.dart';

@freezed
abstract class TasksState with _$TasksState {
  const factory TasksState({
    List<Task> tasks,
    @Default(0) int counter,
    @Default(true) bool isLoading,
  }) = _TasksState;

  const TasksState._();
}

final tasksProvider = StateNotifierProvider.autoDispose<TasksNotifier>((ref) {
  return TasksNotifier(ref);
});

final textFieldProvider = StateProvider<String>((ref) {
  return '';
});

class TasksNotifier extends StateNotifier<TasksState> {
  final TaskRepository taskRepository;

  TasksNotifier(ProviderReference ref)
      : taskRepository = ref.read(taskRepositoryProvider),
        super(TasksState()) {
    _initTasks();
  }

  _initTasks() async {
    final tasks = await taskRepository.fetchTasks('todos');
    state =
        state.copyWith(tasks: tasks, isLoading: false, counter: tasks.length);
  }

  void add(String taskText) async {
    final task = Task(task: taskText);
    taskRepository.insertTask('todos', task.toMap());
    final List<Task> updatedTasks = List.from(state.tasks)..add(task);
    state = state.copyWith(
        tasks: updatedTasks, isLoading: false, counter: updatedTasks.length);
  }

  void delete(String id) {
    final updatedTasks = state.tasks.where((task) => task.id != id).toList();
    taskRepository.delteTask('todos', id);
    state = state.copyWith(tasks: updatedTasks, counter: updatedTasks.length);
  }

  void update(String id) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == id) {
        taskRepository.updateTask(
            'todos', task.copyWith(isDone: !task.isDone).toMap());
        return task.copyWith(isDone: !task.isDone);
      }
      return task;
    }).toList();
    state = state.copyWith(tasks: updatedTasks);
  }
}
