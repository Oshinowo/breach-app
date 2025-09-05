import 'package:flutter/foundation.dart';

import '../model/category.dart';

class Categories with ChangeNotifier {
  List<CategoryModel> _items = [];

  List<CategoryModel> get items => [..._items];

  set setItems(List<CategoryModel> items) {
    _items = items;
    notifyListeners();
  }

  void clearItems() {
    _items = [];
    notifyListeners();
  }

  CategoryModel findById(int categoryId) {
    return _items.firstWhere((item) => item.id == categoryId);
  }
}
