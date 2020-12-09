import 'package:flutter/foundation.dart';
import 'package:shoppinglist/models/item.dart';
import 'dart:collection';
import 'item.dart';

class ItemData extends ChangeNotifier {
  List<ShopListItem> _items = [
    ShopListItem(name: 'Хлеб'),
    ShopListItem(name: 'Сок'),
    ShopListItem(name: 'Молоко'),
  ];
  UnmodifiableListView<ShopListItem> get items {
    return UnmodifiableListView(_items);
  }
//
//  int doneCount = 0;
//
//  int get itemCount {
//    return _items.length;
//  }
//
//  void addItem(String newItemTitle) async {
//    final item = ShopListItem(name: newItemTitle);
//    _items.add(item);
//    notifyListeners();
//  }
//
//  void deleteItem(ShopListItem item) {
//    _items.remove(item);
//    notifyListeners();
//  }
}
