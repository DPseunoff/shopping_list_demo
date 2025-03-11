import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/dao/shopping_list_dao.dart';
import '../../domain/model/shopping_item.dart';

class ShoppingListSPDataBase implements ShoppingListDao {
  static const _shoppingListKey = 'shopping_list_key';

  Future<SharedPreferences> get sharedPrefs async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }

  @override
  Future<List<ShoppingItem>> loadItems() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final strings = sharedPrefs.getStringList(_shoppingListKey);
    final jsons = strings?.map((string) => jsonDecode(string));
    final items = jsons?.map((json) => ShoppingItem.fromJson(json)).toList();
    return items ?? [];
  }

  @override
  Future<void> saveItem(ShoppingItem item) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final currentItems = await loadItems();
    currentItems.add(item);

    final jsons = currentItems.map((item) => item.toJson());
    final strings = jsons.map((json) => jsonEncode(json)).toList();

    sharedPrefs.setStringList(_shoppingListKey, strings);
  }

  @override
  Future<void> updateItem(ShoppingItem item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(String id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {}
}
