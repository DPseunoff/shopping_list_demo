import 'package:flutter/cupertino.dart';

import '../../domain/dao/shopping_list_dao.dart';
import '../../domain/model/shopping_item.dart';

/// Простейшая реализация, хранящая данные в памяти.
class ShoppingListRuntimeDataBase implements ShoppingListDao {
  static const _operationsDelay = Duration(seconds: 1);

  @visibleForTesting
  final Map<String, ShoppingItem> items = {};

  @override
  Future<List<ShoppingItem>> loadItems() => Future.delayed(
        _operationsDelay,
        () => List.unmodifiable(items.values),
      );

  @override
  Future<void> saveItem(ShoppingItem item) async {
    await Future.delayed(_operationsDelay);
    items[item.id] = item;
  }

  @override
  Future<void> updateItem(ShoppingItem item) async {
    await Future.delayed(_operationsDelay);

    if (!items.containsKey(item.id)) {
      throw Exception();
    }

    items[item.id] = item;
  }

  @override
  Future<void> deleteItem(String id) async {
    await Future.delayed(_operationsDelay);

    if (!items.containsKey(id)) {
      throw Exception();
    }

    items.remove(id);
  }

  @override
  Future<void> dispose() async {}
}
