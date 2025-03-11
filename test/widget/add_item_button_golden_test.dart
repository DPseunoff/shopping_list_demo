import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shopping_list_demo/widget/add_item_button.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group(
    'Golden тест для нашей кнопки',
    () {
      testWidgets(
        'Состояние готовности',
        (tester) async {
          // arrange
          const button = AddItemButton();
          await tester.pumpWidget(
            const MaterialApp(home: Scaffold(body: button)),
          );

          // act
          final buttonFinder = find.byType(AddItemButton);

          // aspect
          await expectLater(
            buttonFinder,
            matchesGoldenFile('goldens/add_item_button_idle.png'),
          );
        },
      );

      testWidgets(
        'Состояние загрузки',
        (tester) async {
          // arrange
          const loadingButton = AddItemButton(
            buttonState: AddItemButtonState.loading,
          );
          await tester.pumpWidget(
            const MaterialApp(home: Scaffold(body: loadingButton)),
          );

          await tester.pump(const Duration(milliseconds: 350));

          // act
          final buttonFinder = find.byType(AddItemButton);

          // aspect
          await expectLater(
            buttonFinder,
            matchesGoldenFile('goldens/add_item_button_loading.png'),
          );
        },
      );
    },
  );
}
