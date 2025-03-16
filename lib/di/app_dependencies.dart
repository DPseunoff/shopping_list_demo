import 'package:flutter/widgets.dart';

import 'dependencies_container.dart';

class AppDependencies extends StatefulWidget {
  final DependenciesContainer container;
  final Widget child;

  const AppDependencies({
    required this.container,
    required this.child,
    super.key,
  });

  static DependenciesContainer of(BuildContext context) =>
      _AppDependenciesInherited.of(context).container;

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  @override
  Widget build(BuildContext context) => _AppDependenciesInherited(
        container: widget.container,
        child: widget.child,
      );

  @override
  void dispose() {
    widget.container.shoppingListDao.dispose();
    super.dispose();
  }
}

class _AppDependenciesInherited extends InheritedWidget {
  final DependenciesContainer container;

  const _AppDependenciesInherited({
    Key? key,
    required this.container,
    required Widget child,
  }) : super(key: key, child: child);

  static _AppDependenciesInherited of(BuildContext context) {
    final _AppDependenciesInherited? result =
        context.dependOnInheritedWidgetOfExactType<_AppDependenciesInherited>();
    assert(result != null, 'No AppDependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_AppDependenciesInherited oldWidget) =>
      container != oldWidget.container;
}
