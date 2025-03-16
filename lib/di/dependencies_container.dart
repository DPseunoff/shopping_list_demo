import '../data/data_base/runtime_data_base.dart';
import '../domain/dao/shopping_list_dao.dart';
import '../domain/manager/shopping_list_manager.dart';

class DependenciesContainer {
  final ShoppingListDao shoppingListDao;
  final ShoppingListManager shoppingListManager;

  const DependenciesContainer._({
    required this.shoppingListDao,
    required this.shoppingListManager,
  });

  static DependenciesContainer runtime() {
    final dao = ShoppingListRuntimeDataBase();
    final manager = ShoppingListManager(dao);
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }
}
