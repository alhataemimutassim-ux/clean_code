import 'package:flutter/material.dart';
import 'package:clean_architecture_example/inventory/models/inventory_item.dart';

class InventoryProvider extends ChangeNotifier {
  final List<InventoryItem> _items = [];

  List<InventoryItem> get items => List.unmodifiable(_items);

  void loadItems() {
    // sample seed data
    _items.clear();
    _items.addAll([
      InventoryItem(id: '1', name: 'Apples', quantity: 120, location: 'A1'),
      InventoryItem(id: '2', name: 'Bananas', quantity: 80, location: 'A2'),
      InventoryItem(id: '3', name: 'Oranges', quantity: 45, location: 'B1'),
    ]);
    notifyListeners();
  }

  void addItem(InventoryItem item) {
    _items.add(item);
    notifyListeners();
  }

  void addSampleItem() {
    final item = InventoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'New Item',
      quantity: 1,
      location: 'Unknown',
    );
    addItem(item);
  }

  void updateQuantity(String id, int delta) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = _items[idx];
    current.quantity = (current.quantity + delta).clamp(0, 1000000);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
