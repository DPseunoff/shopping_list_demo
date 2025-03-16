import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_list_demo/domain/dao/shopping_list_dao.dart';
import 'package:shopping_list_demo/domain/manager/shopping_list_manager.dart';
import 'package:shopping_list_demo/domain/manager/shopping_list_state.dart';
import 'package:shopping_list_demo/domain/model/shopping_item.dart';

import '../dao/mock_shopping_list_dao.dart';

void main() {
  late final ShoppingListManager shoppingListManager;
  late final ShoppingListDao shoppingListDao;

  setUpAll(() {
    shoppingListDao = MockShoppingListDao();

    shoppingListManager = ShoppingListManager(shoppingListDao);
  });

  tearDownAll(() {
    reset(shoppingListDao);
  });

  group(
    'Проверка подгрузки данных',
    () {
      test(
        'Успешная подгрузка данных',
        () async {
          // arrange
          when(() => shoppingListDao.loadItems()).thenAnswer(
            (_) async => const [],
          );

          // act
          await shoppingListManager.loadItems();

          // assert
          expect(shoppingListManager.items, isEmpty);
        },
      );

      test(
        'Неудачная подгрузка данных',
        () async {
          // arrange
          when(() => shoppingListDao.loadItems()).thenThrow(Exception());

          // act
          await shoppingListManager.loadItems();

          // assert
          expect(shoppingListManager.state, equals(ShoppingListState.error));
        },
      );
    },
  );

  group(
    'Сохранение покупки',
    () {
      const name = 'Ratatouille';
      const name2 = 'Pizza';
      const name3 = 'Ramen';
      const item = ShoppingItem(
        id: 'unique_id',
        name: name,
      );

      setUp(() {
        registerFallbackValue(item);
      });

      test(
        'Удачное сохранение данных',
        () async {
          // arrange
          when(() => shoppingListDao.saveItem(any<ShoppingItem>()))
              .thenAnswer((_) async {});

          // act
          await shoppingListManager.addItem(name);

          // assert
          expect(
            shoppingListManager.items.map((item) => item.name).toList(),
            contains(name),
          );
          expect(shoppingListManager.state, equals(ShoppingListState.idle));

          final verification = verify(() => shoppingListDao
              .saveItem(captureAny(that: isA<ShoppingItem>()))).captured;

          expect(verification.first.name, name);
        },
      );

      test(
        'При сохранении произошла ошибка',
        () async {
          // arrange
          when(() => shoppingListDao.saveItem(any())).thenThrow(Exception());

          // act
          await shoppingListManager.addItem(name2);

          // assert
          expect(
            shoppingListManager.items.map((item) => item.name).toList(),
            isNot(contains(name2)),
          );
          expect(shoppingListManager.state, equals(ShoppingListState.idle));

          verify(() => shoppingListDao.saveItem(any())).called(1);
        },
      );

      test(
        'Нельзя вызвать сохранение дважды',
        () {
          // arrange
          when(() => shoppingListDao.saveItem(any()))
              .thenAnswer((_) => Future.delayed(const Duration(seconds: 3)));

          // act
          shoppingListManager.addItem(name3);
          shoppingListManager.addItem(name3);

          // assert
          verify(() => shoppingListDao.saveItem(any())).called(1);
        },
      );

      test(
        'Нельзя сохранить вещь без имени',
        () {
          // arrange
          when(() => shoppingListDao.saveItem(any())).thenAnswer((_) async {});

          // act
          shoppingListManager.addItem('');

          // assert
          verifyNever(() => shoppingListDao.saveItem(any()));
        },
      );
    },
  );
}
