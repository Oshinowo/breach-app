// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? email;

  UserModel({this.id, this.email});

  static UserModel fromJson(json) =>
      UserModel(id: json['id'] as int?, email: json['email'] as String?);

  @override
  String toString() => 'UserModel(id: $id, email: $email)';
}
