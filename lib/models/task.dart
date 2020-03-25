import 'package:equatable/equatable.dart';
import 'package:todone/blocs/task/task_entity.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id;
  final String todo;
  final String project;
  final DateTime dueDate;
  final String note;
  final bool completed;

  Task(
    this.todo, {
    this.completed = false,
    String project = '',
    DateTime dueDate,
    String note = '',
    String id,
  })  : this.note = note ?? '',
        this.project = project ?? '',
        this.dueDate = dueDate ?? null,
        this.id = id ?? Uuid().v1();

  Task copyWith({
    bool completed,
    String id,
    String project,
    DateTime dueDate,
    String note,
    String task,
  }) {
    return Task(
      todo ?? this.todo,
      completed: completed ?? this.completed,
      project: project ?? this.project,
      dueDate: dueDate ?? this.dueDate,
      note: note ?? this.note,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [completed, id, note, todo];

  @override
  String toString() {
    return 'Todo { completed: $completed, todo: $todo, note: $note, id: $id }';
  }

  TaskEntity toEntity() {
    return TaskEntity(todo, id, project, dueDate, note, completed);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.todo,
      completed: entity.completed ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().v1(),
    );
  }
}
