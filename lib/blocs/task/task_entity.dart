// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class TaskEntity {
  final String id;
  final String todo;
  final String project;
  final DateTime dueDate;
  final String note;
  final bool completed;

  TaskEntity(
    this.todo,
    this.id,
    this.project,
    this.dueDate,
    this.note,
    this.completed,
  );

  @override
  int get hashCode =>
      completed.hashCode ^ todo.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          completed == other.completed &&
          todo == other.todo &&
          note == other.note &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'todo': todo,
      'project': project,
      'dueDate': dueDate,
      'note': note,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{completed: $completed, todo: $todo, note: $note, id: $id}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
      json['todo'] as String,
      json['id'] as String,
      json['project'] as String,
      json['dueDate'] as DateTime,
      json['note'] as String,
      json['completed'] as bool,
    );
  }
}
