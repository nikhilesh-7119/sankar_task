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
      id: json['id'],
      title: json['title'],
      description: json['description'],
      lastDateText: json['lastDateText'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lastDateText': lastDateText,
      'completed': completed,
    };
  }
}