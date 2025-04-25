import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';

class TaskStatusDialog extends ConsumerStatefulWidget {
  final Task task;

  const TaskStatusDialog({required this.task, super.key});

  @override
  ConsumerState<TaskStatusDialog> createState() => _TaskStatusDialogState();
}

class _TaskStatusDialogState extends ConsumerState<TaskStatusDialog> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    final currentStatus = widget.task.status ?? 'unknown';

    return AlertDialog(
      title: const Text("Change Task Status"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Current Status: ${_capitalize(currentStatus)}"),
          const SizedBox(height: 16),

          if (currentStatus == 'pending' || currentStatus == 'unknown') ...[
            _buildRadio('ongoing'),
            _buildRadio('done'),
          ] else if (currentStatus == 'ongoing') ...[
            _buildRadio('done'),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (selectedStatus != null && selectedStatus != currentStatus) {
              _updateTaskStatus(selectedStatus!);
            }
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }

  Widget _buildRadio(String status) {
    return RadioListTile<String>(
      title: Text("Mark as ${_capitalize(status)}"),
      value: status,
      groupValue: selectedStatus,
      onChanged: (String? value) {
        setState(() {
          selectedStatus = value;
        });
      },
    );
  }

  void _updateTaskStatus(String newStatus) {
    ref.read(taskProvider.notifier).updateStatus(widget.task.id, newStatus);
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
