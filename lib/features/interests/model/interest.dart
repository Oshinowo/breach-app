// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:breach_app/features/blog/model/category.dart';

import '../../profile/model/user.dart';

class InterestModel {
  int? id;
  CategoryModel? category;
  UserModel? user;

  InterestModel({this.id, this.category, this.user});

  static InterestModel fromJson(json) => InterestModel(
    id: json['id'] as int?,
    category: CategoryModel.fromJson(json['category']),
    user: UserModel.fromJson(json['user']),
  );

  @override
  String toString() => 'InterestModel(id: $id, category: $category, user: $user)';
}
