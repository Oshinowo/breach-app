// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:breach_app/features/blog/model/author.dart';

import 'category.dart';
import 'series.dart';

class PostModel {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  String? createdAt;
  AuthorModel? author;
  CategoryModel? category;
  SeriesModel? series;

  PostModel({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
    this.author,
    this.category,
    this.series,
  });

  static PostModel fromJson(json) => PostModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    imageUrl: json['imageUrl'] as String?,
    createdAt: json['createdAt'] as String?,
    author: AuthorModel.fromJson(json['author']),
    category: CategoryModel.fromJson(json['category']),
    series: SeriesModel.fromJson(json['series']),
  );

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, content: $content, imageUrl: $imageUrl, createdAt: $createdAt, author: $author, category: $category, series: $series)';
  }
}
