import 'package:sankar_task/constants/app_constants.dart';

class TaskModel {

  final String id;
  final String title;
  final String description;
  final String lastDateText;
  final bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lastDateText,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[AppConstants.fieldId],
      title: json[AppConstants.fieldTitle],
      description: json[AppConstants.fieldDescription],
      lastDateText: json[AppConstants.fieldLastDateText],
      completed: json[AppConstants.fieldCompleted],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.fieldId: id,
      AppConstants.fieldTitle: title,
      AppConstants.fieldDescription: description,
      AppConstants.fieldLastDateText: lastDateText,
      AppConstants.fieldCompleted: completed,
    };
  }
}
