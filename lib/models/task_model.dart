enum Urgency { high, medium, low }

class TaskModel {
  final String id;
  String title;
  String category;
  String lastDateText; // plain text date
  Urgency urgency;
  bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.lastDateText,
    required this.urgency,
    required this.completed,
  });
}
