import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/repositories/task_repository/task_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({this.taskRepository}) : super((TodosLoading()));
  final TaskRepository taskRepository;

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is TodosLoaded) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodosAdded) {
      yield* _mapTodosAddedToState(event);
    } else if (event is TodosDelete) {
      yield* _mapTodosDeleteToState(event);
    } else if (event is TodosUpdate) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await taskRepository.fetchTasks('todos');

      yield TodosLoadSuccess(todos);
    } catch (_) {
      yield TodosFailure();
    }
  }

  Stream<TodosState> _mapTodosAddedToState(TodosAdded event) async* {
    try {
      final List<Task> updatedTasks =
          List.from((state as TodosLoadSuccess).tasks)..add(event.task);
      yield TodosLoadSuccess(updatedTasks);
      taskRepository.insertTask('todos', event.task.toMap());
    } catch (_) {
      yield TodosFailure();
    }
  }

  Stream<TodosState> _mapTodosDeleteToState(TodosDelete event) async* {
    try {
      final updatedTasks = (state as TodosLoadSuccess)
          .tasks
          .where((task) => task.id != event.id)
          .toList();
      yield TodosLoadSuccess(updatedTasks);
      taskRepository.delteTask('todos', event.id);
    } catch (_) {
      yield TodosFailure();
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdate event) async* {
    try {
      final updatedTasks = (state as TodosLoadSuccess)
          .tasks
          .map((task) => task.id == event.task.id ? event.task : task)
          .toList();
      yield TodosLoadSuccess(updatedTasks);
      taskRepository.updateTask('todos', event.task.toMap());
    } catch (_) {
      yield TodosFailure();
    }
  }
}
