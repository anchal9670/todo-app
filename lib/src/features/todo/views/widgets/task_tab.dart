import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/views/widgets/task_dialog.dart';
import 'package:todoapp/src/features/todo/views/widgets/task_tile.dart';

class TaskTab extends ConsumerWidget {
  final String status;

  const TaskTab({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todayTaskProvider);
    final filtered = tasks.where((t) => t.status == status).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text("No tasks here."));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (_, index) {
        final task = filtered[index];
        return TaskTile(
          task: task,
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => TaskStatusDialog(task: task),
            );
          },
        );
      },
    );
  }
}
