import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../dao/shopping_list_dao.dart';
import '../model/shopping_item.dart';
import 'shopping_list_state.dart';

/// Менеджер. Управляет:
/// 1) Списком товаров в памяти для UI.
/// 2) Вызывает методы репозитория для сохранения/обновления/удаления.
/// 3) Хранит текущее состояние для UI (idle, loading, data и т.д.).
class ShoppingListManager extends ChangeNotifier {
  final ShoppingListDao dao;

  ShoppingListManager(this.dao);

  // Список товаров.
  List<ShoppingItem> _items = [];

  // Текущее состояние менеджера.
  ShoppingListState _state = ShoppingListState.loading;

  List<ShoppingItem> get items => _items;

  ShoppingListState get state => _state;

  /// Загрузка списка из репозитория.
  Future<void> loadItems() async {
    try {
      final loaded = await dao.loadItems();
      _items = List.of(loaded);
      _state = ShoppingListState.idle;
      notifyListeners();
    } on Exception {
      _state = ShoppingListState.error;
      notifyListeners();
    }
  }

  /// Добавление нового элемента (создаём item, сохраняем в репо).
  Future<void> addItem(String name) async {
    if (name.isEmpty || _state == ShoppingListState.itemSaveProgress) {
      return;
    }

    _state = ShoppingListState.itemSaveProgress;
    notifyListeners();

    final newItem = ShoppingItem(
      id: const Uuid().v1(),
      name: name,
      isBought: false,
    );

    _items = [..._items, newItem];
    notifyListeners();

    try {
      await dao.saveItem(newItem);
    } on Exception {
      _items.removeLast();
      _state = ShoppingListState.itemSaveError;
      notifyListeners();
    } finally {
      _setIdleState();
    }
  }

  /// Пометить товар купленным/не купленным (в UI — "toggle").
  Future<void> toggleBought(String id) async {
    final index = _items.indexWhere((e) => e.id == id);

    if (index == -1) {
      return;
    }

    final oldItem = _items[index];
    final newItem = oldItem.copyWith(isBought: !oldItem.isBought);
    _items[index] = newItem;
    notifyListeners();

    try {
      await dao.updateItem(id, newItem);
    } on Exception {
      _items[index] = oldItem;
      _state = ShoppingListState.itemChangeError;
      notifyListeners();
    } finally {
      _setIdleState();
    }
  }

  /// Удаление элемента по ID.
  Future<void> removeItem(String id) async {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) {
      return;
    }

    final oldItem = _items.removeAt(index);
    notifyListeners();

    try {
      await dao.deleteItem(id);
    } on Exception {
      _items.insert(index, oldItem);
      _state = ShoppingListState.itemDeleteError;
      notifyListeners();
    } finally {
      _setIdleState();
    }
  }

  void _setIdleState() {
    _state = ShoppingListState.idle;
    notifyListeners();
  }
}
