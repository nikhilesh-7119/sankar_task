import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/task_controller.dart';

void openTaskDialog({
  String? taskId,
  bool isEdit = false,
}) {

  final controller = Get.find<TaskController>();

  showDialog(

    context: Get.context!,

    builder: (_) {

      return AlertDialog(

        title: Text(
          isEdit ? 'Edit Task' : 'Add Task',
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: controller.title,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: controller.description,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),

            const SizedBox(height: 12),

            Obx(() => CheckboxListTile(

              value: controller.completed.value,

              onChanged: (value) {
                controller.completed.value = value!;
              },

              title: const Text('Completed'),
            )),
          ],
        ),

        actions: [

          TextButton(

            onPressed: () {

              controller.clearFields();

              Get.back();
            },

            child: const Text('Cancel'),
          ),

          ElevatedButton(

            onPressed: () async {

              if (isEdit) {

                await controller.updateTask(taskId!);

              } else {

                await controller.addTask();
              }

              Get.back();
            },

            child: Text(
              isEdit ? 'Update' : 'Add',
            ),
          ),
        ],
      );
    },
  );
}