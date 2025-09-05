// ignore_for_file: public_member_api_docs, sort_constructors_first
class SeriesModel {
  int? id;
  String? name;

  SeriesModel({this.id, this.name});

  static SeriesModel fromJson(json) =>
      SeriesModel(id: json['id'] as int?, name: json['name'] as String);

  @override
  String toString() => 'SeriesModel(id: $id, name: $name)';
}
