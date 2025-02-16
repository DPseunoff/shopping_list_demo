import '../../domain/dao/shopping_list_dao.dart';
import '../../domain/model/shopping_item.dart';

/// Простейшая реализация, хранящая данные в памяти.
class ShoppingListRuntimeDataBase implements ShoppingListDao {
  static const _operationsDelay = Duration(seconds: 1);

  final Map<String, ShoppingItem> _items = {};

  @override
  Future<List<ShoppingItem>> loadItems() => Future.delayed(
        _operationsDelay,
        () => List.unmodifiable(_items.values),
      );

  @override
  Future<void> saveItem(ShoppingItem item) async {
    await Future.delayed(_operationsDelay);
    _items[item.id] = item;
  }

  @override
  Future<void> updateItem(ShoppingItem item) async {
    await Future.delayed(_operationsDelay);

    if (!_items.containsKey(item.id)) {
      throw Exception();
    }

    _items[item.id] = item;
  }

  @override
  Future<void> deleteItem(String id) async {
    await Future.delayed(_operationsDelay);

    if (!_items.containsKey(id)) {
      throw Exception();
    }

    _items.remove(id);
  }
}
