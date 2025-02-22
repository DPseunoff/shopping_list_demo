import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_list_demo/di/app_dependencies.dart';
import 'package:shopping_list_demo/di/dependencies_container.dart';
import 'package:shopping_list_demo/main.dart';
import 'package:shopping_list_demo/widget/add_item_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final Widget myApp;

  setUpAll(() {
    final container = DependenciesContainerFactory.defaultt();

    myApp = AppDependencies(
      container: container,
      child: const MyApp(),
    );
  });

  group(
    'Тестируем работу с покупками',
    () {
      testWidgets(
        'Сохранение покупки',
        (widgetTester) async {
          const shoppingItemName = 'Diamond';

          await widgetTester.pumpWidget(myApp);
          await widgetTester.pumpAndSettle();

          final buttonFinder = find.byType(AddItemButton);

          await widgetTester.tap(buttonFinder);
          await widgetTester.pumpAndSettle();

          final textInputFinder = find.byKey(const ValueKey('text_field'));
          final saveButton = find.text('Save');

          await widgetTester.enterText(textInputFinder, shoppingItemName);
          await widgetTester.tap(saveButton);
          await widgetTester.pumpAndSettle();

          final itemFinder = find.text(shoppingItemName);

          expect(itemFinder, findsOne);
        },
      );

      testWidgets(
        'Чекбокс после нажатия',
        (widgetTester) async {
          await widgetTester.pumpWidget(myApp);
          await widgetTester.pumpAndSettle();

          final checkBoxFinder = find.byType(Checkbox);

          await widgetTester.tap(checkBoxFinder);
          await widgetTester.pump();

          final checkBoxWidget =
              widgetTester.firstWidget<Checkbox>(checkBoxFinder);

          expect(checkBoxWidget.value, isTrue);
        },
      );

      testWidgets(
        'Удаление покупки',
        (widgetTester) async {
          const shoppingItemName = 'Diamond';

          await widgetTester.pumpWidget(myApp);
          await widgetTester.pumpAndSettle();

          final deleteButtonFinder =
              find.byWidgetPredicate((widget) => widget is IconButton);

          await widgetTester.tap(deleteButtonFinder);
          await widgetTester.pump(const Duration(milliseconds: 500));

          final itemFinder = find.text(shoppingItemName);

          expect(itemFinder, findsNothing);
        },
      );
    },
  );
}
