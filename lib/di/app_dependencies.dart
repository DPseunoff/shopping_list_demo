import 'package:flutter/widgets.dart';

import 'dependencies_container.dart';

class AppDependencies extends InheritedWidget {
  final DependenciesContainer container;

  const AppDependencies({
    Key? key,
    required this.container,
    required Widget child,
  }) : super(key: key, child: child);

  /// Метод для получения AppDependencies из контекста.
  static AppDependencies of(BuildContext context) {
    final AppDependencies? result =
        context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'No AppDependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) =>
      container != oldWidget.container;
}
