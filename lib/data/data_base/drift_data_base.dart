import 'package:drift/drift.dart';
import 'package:shopping_list_demo/data/model/drift_database.dart';
import 'package:shopping_list_demo/domain/dao/shopping_list_dao.dart';
import 'package:shopping_list_demo/domain/model/shopping_item.dart';

class ShoppingListDriftDataBase implements ShoppingListDao {
  final AppDatabase _database;

  ShoppingListDriftDataBase(this._database);

  @override
  Future<List<ShoppingItem>> loadItems() async {
    final tableItems =
        await _database.select(_database.shoppingListItemTable).get();
    final items = tableItems
        .map(
          (item) => ShoppingItem(
            id: item.id,
            name: item.name,
            isBought: item.isBought,
          ),
        )
        .toList();

    return items;
  }

  @override
  Future<void> saveItem(ShoppingItem item) async {
    await _database.into(_database.shoppingListItemTable).insert(
          ShoppingListItemTableCompanion.insert(
            id: item.id,
            name: item.name,
            isBought: item.isBought,
          ),
        );
  }

  @override
  Future<void> updateItem(ShoppingItem item) async {
    await (_database.update(_database.shoppingListItemTable)
          ..where((table) => table.id.equals(item.id)))
        .write(
      ShoppingListItemTableCompanion(
        isBought: Value(item.isBought),
      ),
    );
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_database.delete(_database.shoppingListItemTable)
          ..where((table) => table.id.equals(id)))
        .go();
  }
}
