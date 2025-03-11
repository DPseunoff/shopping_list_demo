import '../model/shopping_item.dart';

/// Контракт для объекта доступа к данным.
///
/// Отвечает только за операции CRUD.
abstract class ShoppingListDao {
  /// Загрузить все сохранённые элементы.
  Future<List<ShoppingItem>> loadItems();

  /// Сохранить (добавить) элемент.
  Future<void> saveItem(ShoppingItem item);

  /// Обновить (изменить) элемент.
  Future<void> updateItem(ShoppingItem item);

  /// Удалить элемент по ID.
  Future<void> deleteItem(String id);

  Future<void> dispose();
}
