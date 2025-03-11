import 'package:path_provider/path_provider.dart';
import 'package:shopping_list_demo/data/data_base/file_data_base.dart';
import 'package:shopping_list_demo/data/model/drift_database.dart';

import '../data/data_base/drift_data_base.dart';
import '../data/data_base/object_box_data_base.dart';
import '../data/data_base/shared_prefs_data_base.dart';
import '../domain/dao/shopping_list_dao.dart';
import '../domain/manager/shopping_list_manager.dart';
import '../objectbox.g.dart';

class DependenciesContainer {
  final ShoppingListDao shoppingListDao;
  final ShoppingListManager shoppingListManager;

  const DependenciesContainer._({
    required this.shoppingListDao,
    required this.shoppingListManager,
  });

  static DependenciesContainer withFile() {
    final dao = ShoppingListFileDataBase();
    final manager = ShoppingListManager(dao);
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  static DependenciesContainer withSP() {
    final dao = ShoppingListSPDataBase();
    final manager = ShoppingListManager(dao);
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  static Future<DependenciesContainer> withObjectBox() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final objectBoxStore = await openStore(
      directory: '${docsDir.path}/obx_database',
    );
    final dao = ShoppingListObjectBoxDataBase(objectBoxStore);
    final manager = ShoppingListManager(dao);
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  static DependenciesContainer withDrift() {
    final database = AppDatabase();
    final dao = ShoppingListDriftDataBase(database);
    final manager = ShoppingListManager(dao);
    return DependenciesContainer._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }
}
