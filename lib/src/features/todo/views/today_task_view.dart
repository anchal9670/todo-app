import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/src/common/widgets/reusable_button.dart';
import 'package:todoapp/src/common/widgets/reusable_text_field.dart';
import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';
import 'package:todoapp/src/features/todo/views/widgets/task_tab.dart';

class TodayTasksView extends ConsumerWidget {
  const TodayTasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Today's Tasks"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Ongoing"),
              Tab(text: "Done"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TaskTab(status: 'pending'),
            TaskTab(status: 'ongoing'),
            TaskTab(status: 'done'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context, ref),
          child: const Icon(Icons.add),
        ),
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
