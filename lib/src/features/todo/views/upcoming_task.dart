import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/src/common/widgets/reusable_button.dart';
import 'package:todoapp/src/common/widgets/reusable_text_field.dart';
import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';
import 'package:todoapp/src/features/todo/views/widgets/task_tile.dart';

class UpcomingView extends ConsumerWidget {
  const UpcomingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(upcomingTaskProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Tasks")),
      body: Builder(
        builder: (context) {
          final sortedTasks = [...tasks]
            ..sort((a, b) => a.date!.compareTo(b.date!));

          final Map<String, List<Task>> groupedTasks = {};
          for (var task in sortedTasks) {
            final dateStr = DateFormat('dd MMM yyyy').format(task.date!);
            groupedTasks.putIfAbsent(dateStr, () => []).add(task);
          }

          // Flatten into a list of widgets with date headers
          final List<Widget> taskWidgets = [];
          groupedTasks.forEach((date, tasksForDate) {
            taskWidgets.add(
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
            taskWidgets.addAll(
              tasksForDate.map((task) => TaskTile(task: task)),
            );
          });

          return ListView.builder(
            itemCount: taskWidgets.length,
            itemBuilder: (context, index) => taskWidgets[index],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    DateTime selectedDate = DateTime.now();
    final formattedDateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(selectedDate),
    );
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReusableTextField(controller: titleCtrl, hintText: "Title"),
                ReusableTextField(
                  controller: descCtrl,
                  hintText: "Description",
                  maxLines: 3,
                ),
                ReusableTextField(
                  controller: formattedDateCtrl,
                  hintText: "Date",
                  readOnly: true,
                  suffixIcon: Icon(Icons.calendar_month),
                  onSuffixIconTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate) {
                      selectedDate = picked;
                      formattedDateCtrl.text = DateFormat(
                        'dd-MM-yyyy',
                      ).format(selectedDate);
                    }
                  },
                ),
              ],
            ),
            actions: [
              ReusableButton(
                text: "Add Task",
                onPressed: () {
                  ref
                      .read(taskProvider.notifier)
                      .addTask(
                        Task(
                          title: titleCtrl.text,
                          description: descCtrl.text,
                          date: selectedDate,
                          status: "pending",
                        ),
                        context,
                      );
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
    );
  }
}
