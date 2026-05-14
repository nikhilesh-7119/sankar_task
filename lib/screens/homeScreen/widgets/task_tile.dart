import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/task_controller.dart';
import '../../../models/task_model.dart';

class TaskTile extends StatelessWidget {

  final TaskModel task;
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    final taskController = Get.find<TaskController>();

    return Card(

      child: ListTile(

        leading: Checkbox(

          value: task.completed,

          onChanged: (value) async {

            await taskController.db
                .collection('users')
                .doc(taskController.auth.currentUser!.uid)
                .collection('tasks')
                .doc(task.id)
                .update({
              'completed': value,
            });
          },
        ),

        title: Text(

          task.title,

          style: TextStyle(

            decoration:
            task.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(task.description),

            const SizedBox(height: 4),

            Text(
              task.lastDateText,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),

            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                taskController.deleteTask(task.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}