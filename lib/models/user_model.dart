import 'package:sankar_task/constants/app_constants.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json[AppConstants.fieldId];
    name = json[AppConstants.fieldName];
    email = json[AppConstants.fieldEmail];
    password = json[AppConstants.fieldPassword];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data[AppConstants.fieldId] = id;
    _data[AppConstants.fieldName] = name;
    _data[AppConstants.fieldEmail] = email;
    _data[AppConstants.fieldPassword] = password;

    return _data;
  }
}
