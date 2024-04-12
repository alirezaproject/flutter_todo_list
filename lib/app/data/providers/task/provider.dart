import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/app/core/utils/keys.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    var data = jsonDecode(_storage.read(taskKey).toString());
    if (data != null) {
      for (var task in data) {
        tasks.add(Task.fromJson(task));
      }
    }
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
