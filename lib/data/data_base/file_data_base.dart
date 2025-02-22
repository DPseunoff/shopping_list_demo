import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/dao/shopping_list_dao.dart';
import '../../domain/model/shopping_item.dart';

class ShoppingListFileDataBase implements ShoppingListDao {
  Future<File> get _file async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File("${appDir.path}/shopping_list.txt");
    if (!await file.exists()) {
      await file.create();
    }
    return file;
  }

  @override
  Future<List<ShoppingItem>> loadItems() async {
    final file = await _file;

    final strings = await file.readAsLines();
    final jsons = strings.map((string) => jsonDecode(string));
    final items = jsons.map((json) => ShoppingItem.fromJson(json)).toList();
    return items;
  }

  @override
  Future<void> saveItem(ShoppingItem item) async {
    final file = await _file;
    final itemAsString = jsonEncode(item.toJson());
    await file.writeAsString(itemAsString, mode: FileMode.append);
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
}
