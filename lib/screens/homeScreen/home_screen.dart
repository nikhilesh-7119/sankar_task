import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/controller/auth_controller.dart';
import 'package:sankar_task/controller/qoute_controller.dart';
import 'package:sankar_task/controller/task_controller.dart';
import 'package:sankar_task/models/task_model.dart';
import 'package:sankar_task/screens/auth_gateway/auth_gateway.dart';
import 'package:sankar_task/screens/homeScreen/widgets/qoute_card.dart';
import 'package:sankar_task/screens/homeScreen/widgets/task_dialog.dart';
import 'package:sankar_task/screens/homeScreen/widgets/task_tile.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final taskController = Get.put(TaskController());
  final quoteController = Get.put(QuoteController());

  String _displayName = AppConstants.guest;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _db
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .get();
        final data = doc.data();
        if (data != null &&
            (data[AppConstants.fieldName] as String?)?.trim().isNotEmpty ==
                true) {
          _displayName = (data[AppConstants.fieldName] as String).trim();
        }
      }
    } catch (e) {
      // ignore and keep Guest
      Get.snackbar(AppConstants.errorTitle, e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text(AppConstants.homeTitle),

        actions: [
          IconButton(
            onPressed: () async {
              await authController.signOut();

              Get.offAll(AuthGateway());
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // FloatingActionButton kept exactly as requested
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Expanded(
              flex: 7,

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: AppColors.white,

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          AppConstants.tasksHeading,

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            taskController.clearFields();

                            openTaskDialog();
                          },

                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),

                    Expanded(
                      child: StreamBuilder(
                        stream: taskController.getTasks(),

                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(AppConstants.noTasksFound),
                            );
                          }

                          final tasks = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: tasks.length,

                            itemBuilder: (context, index) {
                              final task = TaskModel.fromJson(
                                tasks[index].data(),
                              );

                              return TaskTile(
                                task: task,

                                onEdit: () async {
                                  await taskController.editTask(task.id);

                                  openTaskDialog(taskId: task.id, isEdit: true);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Expanded(flex: 3, child: QuoteCard()),
          ],
        ),
      ),
    );
  }
}
