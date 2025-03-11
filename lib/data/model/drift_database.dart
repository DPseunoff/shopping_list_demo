import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'drift_database.g.dart';

class ShoppingListItemTable extends Table {
  TextColumn get id => text().unique()();

  TextColumn get name => text().withLength(max: 32)();

  BoolColumn get isBought => boolean()();
}

@DriftDatabase(tables: [ShoppingListItemTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(),
    );
  }
}
