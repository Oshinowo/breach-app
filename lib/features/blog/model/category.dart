// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  int? id;
  String? name;
  String? icon;

  CategoryModel({this.id, this.name, this.icon});

  static CategoryModel fromJson(json) => CategoryModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    icon: json['icon'] as String?,
  );

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, icon: $icon)';
}
