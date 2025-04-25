import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';

class SharedPrefsController {
  static const String taskKey = 'task_list';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(taskKey, taskList);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList(taskKey);
    if (taskList == null) return [];
    return taskList
        .map((jsonStr) => Task.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final existingTasks = await loadTasks();
    existingTasks.add(task);
    final updatedTaskList =
        existingTasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(taskKey, updatedTaskList);
  }
}

final sharedPrefsProvider = Provider<SharedPrefsController>((ref) {
  return SharedPrefsController();
});
