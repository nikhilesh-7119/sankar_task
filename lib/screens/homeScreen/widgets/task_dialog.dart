import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';

import '../../../controller/task_controller.dart';

void openTaskDialog({String? taskId, bool isEdit = false}) {
  final controller = Get.find<TaskController>();

  showDialog(
    context: Get.context!,

    builder: (_) {
      return AlertDialog(
        title: Text(isEdit ? AppConstants.editTaskTitle : AppConstants.addTaskTitle),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.title,
              decoration: const InputDecoration(hintText: AppConstants.titleHint),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: controller.description,
              decoration: const InputDecoration(hintText: AppConstants.descriptionHint),
            ),

            const SizedBox(height: 12),

            Obx(
              () => CheckboxListTile(
                value: controller.completed.value,

                onChanged: (value) {
                  controller.completed.value = value!;
                },

                title: const Text(AppConstants.completedLabel),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              controller.clearFields();

              Get.back();
            },

            child: const Text(AppConstants.cancelLabel),
          ),

          ElevatedButton(
            onPressed: () async {
              Get.back();

              if (isEdit) {
                await controller.updateTask(taskId!);
              } else {
                await controller.addTask();
              }
            },

            child: Text(isEdit ? AppConstants.updateLabel : AppConstants.addLabel),
          ),
        ],
      );
    },
  );
}
