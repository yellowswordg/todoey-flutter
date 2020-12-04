import 'dart:convert';

import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String task;
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isDone': isDone == true ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      id: map['id'],
      task: map['task'],
      isDone: map['isDone'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
