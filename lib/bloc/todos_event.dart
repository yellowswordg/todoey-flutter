part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosEvent {
  // TodosInitial(this.tasks);
  // final List<Task> tasks;

  // @override
  // List<Object> get props => [tasks];

}

class TodosLoaded extends TodosEvent {}

class TodosAdded extends TodosEvent {
  TodosAdded(this.task);
  final Task task;

  List<Object> get props => [task];
}

class TodosDelete extends TodosEvent {
  TodosDelete({this.id});
  final String id;
}
