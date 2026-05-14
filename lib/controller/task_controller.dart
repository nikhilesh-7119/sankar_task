import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      await db.collection('users').doc(userId).collection('tasks').doc(taskId).set(task.toJson());
      clearFields();
    } catch (e) {
      Get.snackbar('Error in Adding task',"please check your internet");
    }
  }

  Future<void> editTask(String id) async {

    try {

      final taskDoc = await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('tasks')
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
        "Error",
        "Unable to fetch task",
      );
    }
  }

  Future<void> updateTask(String id) async {

    try {

      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('tasks')
          .doc(id)
          .update({

        'title': title.text.trim(),
        'description': description.text.trim(),
        'completed': completed.value,

      });

      clearFields();

      Get.snackbar(
        "Success",
        "Task Updated",
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        "Unable to update task",
      );
    }
  }

  Future<void> deleteTask(String id) async {
    try{
      await db.collection('users').doc(auth.currentUser!.uid).collection('tasks').doc(id).delete();
    } catch (e){
      Get.snackbar(
        "Error",
        "Unable to delete task",
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {

    return db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .orderBy('lastDateText', descending: true)
        .snapshots();
  }
}