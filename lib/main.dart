import 'package:flutter/material.dart';
import 'package:shopping_list_demo/widget/shopping_list_page.dart';

import 'di/app_dependencies.dart';
import 'di/dependencies_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await DependenciesContainerFactory.basedOnENVFile();

  runApp(
    AppDependencies(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShoppingListPage(),
    );
  }
}
