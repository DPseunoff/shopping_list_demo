import 'package:path_provider/path_provider.dart';
import 'package:shopping_list_demo/data/data_base/file_data_base.dart';
import 'package:shopping_list_demo/data/model/drift_database.dart';

import '../data/data_base/drift_data_base.dart';
import '../data/data_base/object_box_data_base.dart';
import '../data/data_base/runtime_data_base.dart';
import '../data/data_base/shared_prefs_data_base.dart';
import '../data/env.dart';
import '../domain/dao/shopping_list_dao.dart';
import '../domain/manager/shopping_list_manager.dart';
import '../objectbox.g.dart';

class DependenciesContainerFactory {
  final ShoppingListDao shoppingListDao;
  final ShoppingListManager shoppingListManager;

  DependenciesContainerFactory._({
    required this.shoppingListDao,
    required this.shoppingListManager,
  });

  /// Фабрика, создающая контейнер с реализациями по умолчанию.
  factory DependenciesContainerFactory.defaultt() {
    // 1. Создаём data access object.
    final dao = ShoppingListRuntimeDataBase();

    // 2. Создаём менеджер на основе репозитория.
    final manager = ShoppingListManager(dao);

    // 3. Возвращаем контейнер.
    return DependenciesContainerFactory._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  factory DependenciesContainerFactory.withFile() {
    final dao = ShoppingListFileDataBase();
    final manager = ShoppingListManager(dao);
    return DependenciesContainerFactory._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  factory DependenciesContainerFactory.withSP() {
    final dao = ShoppingListSPDataBase();
    final manager = ShoppingListManager(dao);
    return DependenciesContainerFactory._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  factory DependenciesContainerFactory.withObjectBox(Store store) {
    final dao = ShoppingListObjectBoxDataBase(store);
    final manager = ShoppingListManager(dao);
    return DependenciesContainerFactory._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  factory DependenciesContainerFactory.withDrift(AppDatabase database) {
    final dao = ShoppingListDriftDataBase(database);
    final manager = ShoppingListManager(dao);
    return DependenciesContainerFactory._(
      shoppingListDao: dao,
      shoppingListManager: manager,
    );
  }

  static Future<DependenciesContainerFactory> basedOnDartDefine() async {
    const dbType = String.fromEnvironment('DATA_BASE_TYPE');
    return _getDepsByDBType(dbType);
  }

  static Future<DependenciesContainerFactory> basedOnENVFile() async {
    final dbType = Env.dbType;
    return _getDepsByDBType(dbType);
  }

  static Future<DependenciesContainerFactory> _getDepsByDBType(
    String type,
  ) async {
    switch (type) {
      case 'FILE':
        return DependenciesContainerFactory.withFile();
      case 'SHARED_PREFS':
        return DependenciesContainerFactory.withSP();
      case 'OBJECT_BOX':
        final docsDir = await getApplicationDocumentsDirectory();
        final objectBoxStore = await openStore(
          directory: '${docsDir.path}/obx',
        );
        return DependenciesContainerFactory.withObjectBox(objectBoxStore);
      case 'DRIFT':
        final database = AppDatabase();
        return DependenciesContainerFactory.withDrift(database);
    }
    return DependenciesContainerFactory.defaultt();
  }
}
