import 'package:flutter/foundation.dart';

import '../model/post.dart';

class Posts with ChangeNotifier {
  List<PostModel> _items = [];

  List<PostModel> get items => [..._items];

  set setItems(List<PostModel> items) {
    _items = items;
    notifyListeners();
  }

  void clearItems() {
    _items = [];
    notifyListeners();
  }

  PostModel findById(int postId) {
    return _items.firstWhere((item) => item.id == postId);
  }

  List<PostModel> filteredItems({int? categoryId}) =>
      _items.where((post) => post.category?.id == categoryId).toList();
}
