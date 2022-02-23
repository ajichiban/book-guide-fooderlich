import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

   bool _createNewItem = false;

   int? _selectedIndex;

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  get selectedIndex => _selectedIndex;

  get selectedGroceryItem => _groceryItems[_selectedIndex!];

  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void groceryItemTapped(int? index){
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    _selectedIndex = null;
    _createNewItem = false;

    notifyListeners();
  }

  // 6
  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
