part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}


class TodosLoading extends TodosState {}

class TodosLoadSuccess extends TodosState {
  const TodosLoadSuccess([this.tasks = const []]);
  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}

class TodosFailure extends TodosState {}
