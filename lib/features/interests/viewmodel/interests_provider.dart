import 'package:flutter/foundation.dart';

import '../model/interest.dart';

class Interests with ChangeNotifier {
  List<InterestModel> _items = [];

  List<InterestModel> get items => [..._items];

  set setItems(List<InterestModel> items) {
    _items = items;
    notifyListeners();
  }

  void clearItems() {
    _items = [];
    notifyListeners();
  }

  InterestModel findById(int categoryId) {
    return _items.firstWhere((item) => item.id == categoryId);
  }
}
