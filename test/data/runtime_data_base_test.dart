import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_demo/data/data_base/runtime_data_base.dart';
import 'package:shopping_list_demo/domain/model/shopping_item.dart';

void main() {
  final runtimeDataBase = ShoppingListRuntimeDataBase();
  const uniqueId = 'unique_id';

  test(
    'Проверка функции loadItems. Список должен быть пусть при создании',
    () async {
      final resList = await runtimeDataBase.loadItems();
      expect(resList, const []);
    },
  );

  /// Тест отличается от предыдущего только наличием матчера
  test(
    'Проверка функции loadItems. Список должен быть пусть при создании',
    () async {
      final resList = await runtimeDataBase.loadItems();
      expect(resList, isEmpty);
    },
  );

  test(
    'Проверка функции saveItem. Список должен содержать покупку с указанным ID',
    () async {
      const shoppingItem = ShoppingItem(
        id: uniqueId,
        name: 'Say my name',
      );

      await runtimeDataBase.saveItem(shoppingItem);

      expect(runtimeDataBase.items.keys, contains(uniqueId));
    },
  );

  /// Теперь мы объединим тесты в группу для читаемости.
  group(
    'Проверка функции updateItem',
    () {
      late ShoppingItem shoppingItem;

      setUp(() {
        shoppingItem = const ShoppingItem(
          id: uniqueId,
          name: 'Say my name',
          isBought: true,
        );
      });

      test(
        'Переданная покупка должна обновиться',
        () async {
          await runtimeDataBase.updateItem(shoppingItem);
          
          expect(runtimeDataBase.items.keys, contains(uniqueId));
          expect(runtimeDataBase.items[uniqueId]?.isBought, isTrue);
        },
      );

      test(
        'Переданная покупка не была сохранена, возвращается Exception',
        () async {
          const incorrectId = 'incorrect_id';
          const unknownItem = ShoppingItem(
            id: incorrectId,
            name: 'Say my name',
            isBought: false,
          );

          final future = runtimeDataBase.updateItem(unknownItem);

          expect(future, throwsException);
        },
      );
    },
  );
}
