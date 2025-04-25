import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/src/features/todo/controller/task_controller.dart';
import 'package:todoapp/src/features/todo/model/todo_model.dart';
import 'package:todoapp/src/res/colors.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskTile({Key? key, required this.task, this.onTap}) : super(key: key);

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return AppColors.warning;
      case 'ongoing':
        return AppColors.primary;
      case 'done':
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }

  Color _getBackgroundColor(String? status) {
    switch (status) {
      case 'pending':
        return AppColors.pendingBg;
      case 'ongoing':
        return AppColors.ongoingBg;
      case 'done':
        return AppColors.doneBg;
      default:
        return Colors.grey.shade100;
    }
  }

  String _getFormattedStatus(String? status) {
    if (status == null || status.isEmpty) return 'UNKNOWN';
    return status.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd MMM, yyyy').format(task.date!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(task.status),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: _getStatusColor(task.status), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.description!,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormatted,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(task.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getFormattedStatus(task.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(task.status),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
