import 'package:uuid/uuid.dart';

class Task {
  final String task;
  final String id;
  bool isDone;

  Task({this.task, String id, this.isDone = false})
      : this.id = id ?? Uuid().v4();

  Task copyWith({String task, String id, bool isDone}) {
    return Task(
      task: task ?? this.task,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Task && o.task == task && o.id == id && o.isDone == isDone;
  }

  @override
  int get hashCode => task.hashCode ^ id.hashCode ^ isDone.hashCode;
}
