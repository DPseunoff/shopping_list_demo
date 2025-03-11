import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shopping_list_demo/di/app_dependencies.dart';
import 'package:shopping_list_demo/di/dependencies_container.dart';
import 'package:shopping_list_demo/main.dart';

void main() {
  late final DependenciesContainer container;

  setUpAll(() async {
    container = DependenciesContainer.runtime();

    await loadAppFonts();
  });

  group(
    'Тестируем главный экран',
    () {
      testWidgets(
        'Ищем заголовок "Shopping List"',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            AppDependencies(
              container: container,
              child: const MyApp(),
            ),
          );

          await widgetTester.pumpAndSettle();

          final textFinder = find.text('Shopping List');

          expect(textFinder, findsOne);
        },
      );

      testWidgets(
        'Ищем нашу кнопку',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            AppDependencies(
              container: container,
              child: const MyApp(),
            ),
          );

          await widgetTester.pumpAndSettle(const Duration(seconds: 2));

          final buttonFinder = find.byIcon(Icons.checklist);

          expect(buttonFinder, findsOne);
        },
      );
    },
  );

  testGoldens(
    'Тестируем golden главного экрана на разных девайсах',
    (widgetTester) async {
      final page = AppDependencies(
        container: container,
        child: const MyApp(),
      );

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [
            Device.phone,
            Device.iphone11,
            Device.tabletPortrait,
            const Device(size: Size(768, 1024), name: 'iPad mini'),
          ],
        )
        ..addScenario(
          widget: page,
          name: 'Просто экран',
          onCreate: (_) async {
            await widgetTester.pumpAndSettle();
          },
        )
        ..addScenario(
          widget: page,
          name: 'Экран после нажатия',
          onCreate: (scenarioWidgetKey) async {
            await widgetTester.pumpAndSettle();

            final buttonFinder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byIcon(Icons.checklist),
            );

            expect(buttonFinder, findsOneWidget);

            await widgetTester.tap(buttonFinder);
            await widgetTester.pumpAndSettle();
          },
        );

      await widgetTester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(
        widgetTester,
        'shopping_list_page_multiple',
      );
    },
  );
}
