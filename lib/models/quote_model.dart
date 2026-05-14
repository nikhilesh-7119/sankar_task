import 'package:sankar_task/constants/app_constants.dart';

class QuoteModel {

  final String content;
  final String author;

  QuoteModel({
    required this.content,
    required this.author,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {

    return QuoteModel(
      content: json[AppConstants.fieldContent],
      author: json[AppConstants.fieldAuthor],
    );
  }
}
