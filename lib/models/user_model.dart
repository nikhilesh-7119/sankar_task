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
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['password']=password;

    return _data;
  }
}
