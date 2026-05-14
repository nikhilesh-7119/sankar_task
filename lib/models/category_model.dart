import 'dart:ui';

class CategoryModel {
  CategoryModel({
    required this.name,
    required this.percentage,
    required this.color,
    required this.icon,
  });
  final String name;
  double percentage;
  final Color color;
  final String icon;

  CategoryModel copy() => CategoryModel(
    name: name,
    percentage: percentage,
    color: color,
    icon: icon,
  );
}