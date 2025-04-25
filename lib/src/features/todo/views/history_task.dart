import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';
import 'package:todoapp/src/features/todo/views/widgets/task_tile.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(historyTaskProvider)
      ..sort((a, b) => b.date!.compareTo(a.date!));

    // Group by date
    final Map<String, List<Task>> groupedTasks = {};
    for (var task in tasks) {
      final dateStr = DateFormat('dd MMM yyyy').format(task.date!);
      groupedTasks.putIfAbsent(dateStr, () => []).add(task);
    }

    final List<Widget> taskWidgets = [];
    groupedTasks.forEach((date, tasksForDate) {
      taskWidgets.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        ),
      );
      taskWidgets.addAll(tasksForDate.map((task) => TaskTile(task: task)));
    });

    return Scaffold(
      appBar: AppBar(title: Text("History Tasks")),
      body: ListView.builder(
        itemCount: taskWidgets.length,
        itemBuilder: (context, index) => taskWidgets[index],
      ),
    );
  }
}
