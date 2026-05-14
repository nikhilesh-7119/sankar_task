import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/models/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {

  final title=TextEditingController();
  final description=TextEditingController();
  final completed=false.obs;

  final auth= FirebaseAuth.instance;
  final db=FirebaseFirestore.instance;
  final uuid=Uuid();

  void clearFields() {
    title.clear();
    description.clear();
    completed.value = false;
  }

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    super.onClose();
  }

  Future<void> addTask() async {
    final userId=auth.currentUser!.uid;
    final taskId=uuid.v4();
    var task=TaskModel(id: taskId, title: title.text.trim(), description: description.text.trim(), lastDateText: DateTime.now().toString().split(' ')[0], completed: completed.value);
    try{
      await db
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .collection(AppConstants.tasksCollection)
          .doc(taskId)
          .set(task.toJson());
      clearFields();
    } catch (e) {
      Get.snackbar(
        AppConstants.errorAddingTaskTitle,
        AppConstants.errorAddingTaskMsg,
      );
    }
  }

  Future<void> editTask(String id) async {

    try {

      final taskDoc = await db
          .collection(AppConstants.usersCollection)
          .doc(auth.currentUser!.uid)
          .collection(AppConstants.tasksCollection)
          .doc(id)
          .get();

      if (taskDoc.exists) {

        final task = TaskModel.fromJson(taskDoc.data()!);

        title.text = task.title;
        description.text = task.description;

        completed.value = task.completed;

      }

    } catch (e) {

      Get.snackbar(
        AppConstants.errorTitle,
        AppConstants.unableToFetchTask,
      );
    }
  }

  Future<void> updateTask(String id) async {

    try {

      await db
          .collection(AppConstants.usersCollection)
          .doc(auth.currentUser!.uid)
          .collection(AppConstants.tasksCollection)
          .doc(id)
          .update({

        AppConstants.fieldTitle: title.text.trim(),
        AppConstants.fieldDescription: description.text.trim(),
        AppConstants.fieldCompleted: completed.value,

      });

      clearFields();

      Get.snackbar(
        AppConstants.successTitle,
        AppConstants.taskUpdated,
      );

    } catch (e) {

      Get.snackbar(
        AppConstants.errorTitle,
        AppConstants.unableToUpdateTask,
      );
    }
  }

  Future<void> deleteTask(String id) async {
    try{
      await db
          .collection(AppConstants.usersCollection)
          .doc(auth.currentUser!.uid)
          .collection(AppConstants.tasksCollection)
          .doc(id)
          .delete();
    } catch (e){
      Get.snackbar(
        AppConstants.errorTitle,
        AppConstants.unableToDeleteTask,
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {

    return db
        .collection(AppConstants.usersCollection)
        .doc(auth.currentUser!.uid)
        .collection(AppConstants.tasksCollection)
        .orderBy(AppConstants.fieldLastDateText, descending: false)
        .snapshots();
  }
}
