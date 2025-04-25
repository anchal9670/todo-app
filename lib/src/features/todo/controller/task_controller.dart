// import 'dart:developer';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todoapp/src/features/todo/model/todo_model.dart';

// class TodayTaskController extends StateNotifier<List<Task>> {
//   TodayTaskController() : super([]);

//   // Add a task
//   void addTask(Task task) {
//     state = [...state, task];
//   }

//   void updateStatus(String taskId, String status) {
//     state =
//         state.map((task) {
//           if (task.id == taskId) {
//             return task.copyWith(status: status);
//           }
//           return task;
//         }).toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/common/sharedprefs/shared_pref.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';
import 'package:todoapp/src/res/colors.dart';
import 'package:todoapp/src/utils/snackbar_service.dart';

final taskProvider = StateNotifierProvider<TaskController, List<Task>>((ref) {
  final prefsController = ref.watch(sharedPrefsProvider);
  return TaskController(prefsController);
});
final todayTaskProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskProvider);
  final today = DateTime.now();

  return tasks.where((task) {
    return task.date != null &&
        task.date!.year == today.year &&
        task.date!.month == today.month &&
        task.date!.day == today.day;
  }).toList();
});

final upcomingTaskProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskProvider);
  final today = DateTime.now();
  return tasks.where((task) {
    return task.date != null &&
        task.date!.isAfter(today) &&
        task.status != 'done';
  }).toList();
});

final historyTaskProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskProvider);
  final today = DateTime.now();
  return tasks.where((task) {
    return task.date != null && task.date!.isBefore(today) ||
        task.status == 'done';
  }).toList();
});

class TaskController extends StateNotifier<List<Task>> {
  final SharedPrefsController prefsController;

  TaskController(this.prefsController) : super([]) {
    loadAllTasks();
  }

  Future<void> loadAllTasks() async {
    final tasks = await prefsController.loadTasks();
    final today = DateTime.now();

    final updatedTasks =
        tasks.map((task) {
          if (task.date != null &&
              task.date!.isBefore(today) &&
              task.status == 'pending') {
            return task.copyWith(status: 'not done');
          }
          return task;
        }).toList();

    state = updatedTasks;
    await prefsController.saveTasks(updatedTasks);
  }

  Future<void> addTask(Task task, BuildContext context) async {
    state = [...state, task];
    await prefsController.addTask(task);
    SnackBarService.showSnackBar(
      context: context,
      message: "Added New Task",
      backgroundColor: AppColors.success,
    );
  }

  Future<void> updateStatus(String taskId, String status) async {
    state =
        state.map((task) {
          if (task.id == taskId) {
            return task.copyWith(status: status);
          }
          return task;
        }).toList();

    await prefsController.saveTasks(state);
  }
}
