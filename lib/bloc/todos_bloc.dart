import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/task_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({this.taskRepository}) : super((TodosLoading()));
  final TaskRepository taskRepository;

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is TodosInitial) {
      print('initial');
      yield* _mapTodosInitialToState();
    } else if (event is TodosLoaded) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodosAdded) {
      yield* _mapTodosAddedToState(event);
    } else if (event is TodosDelete) {
      yield* _mapTodosDeleteToState(event);
    }
  }

  Stream<TodosState> _mapTodosInitialToState() async* {
    try {
      final todos = await taskRepository.populateList('todos');
      yield TodosLoadSuccess(todos
          .map((item) => Task(
                id: item['id'],
                task: item['task'],
                isDone: item['taks'],
              ))
          .toList());
    } catch (_) {
      yield TodosFailure();
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await taskRepository.getTask('todos');
      yield TodosLoadSuccess(todos
          .map((item) => Task(
                id: item['id'],
                task: item['task'],
                isDone: item['taks'],
              ))
          .toList());
    } catch (_) {
      yield TodosFailure();
    }
  }

  Stream<TodosState> _mapTodosAddedToState(TodosAdded event) async* {
    try {
      final List<Task> updatedTasks =
          List.from((state as TodosLoadSuccess).tasks)..add(event.task);
      yield TodosLoadSuccess(updatedTasks);
      taskRepository.insertTask('todos', {
        'id': event.task.id,
        'task': event.task.task,
        'isDone': event.task.isDone
      });
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
}
