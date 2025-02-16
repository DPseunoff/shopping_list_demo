import '../data/data_base/runtime_data_base.dart';
import '../domain/dao/shopping_list_dao.dart';
import '../domain/manager/shopping_list_manager.dart';

class DependenciesContainer {
  final ShoppingListDao shoppingListDao;
  final ShoppingListManager shoppingListManager;

  DependenciesContainer._({
    required this.shoppingListDao,
    required this.shoppingListManager,
  });

  /// Фабрика, создающая контейнер с реализациями по умолчанию.
  factory DependenciesContainer.create() {
    // 1. Создаём data access object.
    final dao = ShoppingListRuntimeDataBase();

    // 2. Создаём менеджер на основе репозитория.
    final manager = ShoppingListManager(dao);

    // 3. Возвращаем контейнер.
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }
}
