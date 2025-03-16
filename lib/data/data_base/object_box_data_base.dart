import '../../domain/dao/shopping_list_dao.dart';
import '../../domain/model/shopping_item.dart';
import '../../objectbox.g.dart';
import '../model/shopping_item_entity.dart';

class ShoppingListObjectBoxDataBase implements ShoppingListDao {
  final Store _store;

  ShoppingListObjectBoxDataBase(this._store);

  @override
  Future<List<ShoppingItem>> loadItems() async {
    final box = _store.box<ShoppingItemEntity>();

    final entities = box.getAll();
    final items = entities
        .map(
          (entity) => ShoppingItem(
            id: entity.uid,
            name: entity.name,
            isBought: entity.isBought,
          ),
        )
        .toList();

    return items;
  }

  @override
  Future<void> saveItem(ShoppingItem item) async {
    final box = _store.box<ShoppingItemEntity>();

    final entity = ShoppingItemEntity(
      uid: item.id,
      name: item.name,
      isBought: item.isBought,
    );

    box.put(entity);
  }

  @override
  Future<void> updateItem(ShoppingItem item) async {
    final box = _store.box<ShoppingItemEntity>();

    final query = box.query(ShoppingItemEntity_.uid.equals(item.id)).build();
    final boxId = query.findFirst()?.id;
    query.close();

    final entity = ShoppingItemEntity(
      id: boxId ?? 0,
      uid: item.id,
      name: item.name,
      isBought: item.isBought,
    );

    box.put(entity);
  }

  @override
  Future<void> deleteItem(String id) async {
    final box = _store.box<ShoppingItemEntity>();

    final query = box.query(ShoppingItemEntity_.uid.equals(id)).build();
    final boxId = query.findFirst()?.id;
    query.close();

    if (boxId == null) {
      return;
    }

    box.remove(boxId);
  }

  @override
  Future<void> dispose() async => _store.close();
}
