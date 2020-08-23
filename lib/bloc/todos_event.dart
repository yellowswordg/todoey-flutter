part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
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

class TodosUpdate extends TodosEvent {
  TodosUpdate({this.task});
  final Task task;
  List<Object> get props => [task];
}

