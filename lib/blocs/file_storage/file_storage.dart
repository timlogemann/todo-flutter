// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:todone/blocs/task/task_entity.dart';
import 'package:todone/blocs/task/task_repository.dart';

/// Loads and saves a List of Todos using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage implements TaskRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  @override
  Future<List<TaskEntity>> loadTasks() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final tasks = (json['tasks'])
        .map<TaskEntity>((task) => TaskEntity.fromJson(task))
        .toList();

    return tasks;
  }

  @override
  Future<File> saveTasks(List<TaskEntity> tasks) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'tasks': tasks.map((task) => task.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/todone__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
