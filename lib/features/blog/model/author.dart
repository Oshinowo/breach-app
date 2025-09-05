// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthorModel {
  int? id;
  String? name;

  AuthorModel({this.id, this.name});

  static AuthorModel fromJson(json) =>
      AuthorModel(id: json['id'] as int?, name: json['name'] as String?);

  @override
  String toString() => 'AuthorModel(id: $id, name: $name)';
}
