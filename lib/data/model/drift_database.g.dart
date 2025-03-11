// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ShoppingListItemTableTable extends ShoppingListItemTable
    with TableInfo<$ShoppingListItemTableTable, ShoppingListItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isBoughtMeta =
      const VerificationMeta('isBought');
  @override
  late final GeneratedColumn<bool> isBought = GeneratedColumn<bool>(
      'is_bought', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_bought" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, name, isBought];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_list_item_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ShoppingListItemTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_bought')) {
      context.handle(_isBoughtMeta,
          isBought.isAcceptableOrUnknown(data['is_bought']!, _isBoughtMeta));
    } else if (isInserting) {
      context.missing(_isBoughtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ShoppingListItemTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingListItemTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isBought: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bought'])!,
    );
  }

  @override
  $ShoppingListItemTableTable createAlias(String alias) {
    return $ShoppingListItemTableTable(attachedDatabase, alias);
  }
}

class ShoppingListItemTableData extends DataClass
    implements Insertable<ShoppingListItemTableData> {
  final String id;
  final String name;
  final bool isBought;
  const ShoppingListItemTableData(
      {required this.id, required this.name, required this.isBought});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_bought'] = Variable<bool>(isBought);
    return map;
  }

  ShoppingListItemTableCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListItemTableCompanion(
      id: Value(id),
      name: Value(name),
      isBought: Value(isBought),
    );
  }

  factory ShoppingListItemTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingListItemTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isBought: serializer.fromJson<bool>(json['isBought']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isBought': serializer.toJson<bool>(isBought),
    };
  }

  ShoppingListItemTableData copyWith(
          {String? id, String? name, bool? isBought}) =>
      ShoppingListItemTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        isBought: isBought ?? this.isBought,
      );
  ShoppingListItemTableData copyWithCompanion(
      ShoppingListItemTableCompanion data) {
    return ShoppingListItemTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isBought: data.isBought.present ? data.isBought.value : this.isBought,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isBought: $isBought')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isBought);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingListItemTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isBought == this.isBought);
}

class ShoppingListItemTableCompanion
    extends UpdateCompanion<ShoppingListItemTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isBought;
  final Value<int> rowid;
  const ShoppingListItemTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isBought = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShoppingListItemTableCompanion.insert({
    required String id,
    required String name,
    required bool isBought,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        isBought = Value(isBought);
  static Insertable<ShoppingListItemTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isBought,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isBought != null) 'is_bought': isBought,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShoppingListItemTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<bool>? isBought,
      Value<int>? rowid}) {
    return ShoppingListItemTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isBought: isBought ?? this.isBought,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isBought.present) {
      map['is_bought'] = Variable<bool>(isBought.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isBought: $isBought, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShoppingListItemTableTable shoppingListItemTable =
      $ShoppingListItemTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [shoppingListItemTable];
}

typedef $$ShoppingListItemTableTableCreateCompanionBuilder
    = ShoppingListItemTableCompanion Function({
  required String id,
  required String name,
  required bool isBought,
  Value<int> rowid,
});
typedef $$ShoppingListItemTableTableUpdateCompanionBuilder
    = ShoppingListItemTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<bool> isBought,
  Value<int> rowid,
});

class $$ShoppingListItemTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTableTable> {
  $$ShoppingListItemTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBought => $composableBuilder(
      column: $table.isBought, builder: (column) => ColumnFilters(column));
}

class $$ShoppingListItemTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTableTable> {
  $$ShoppingListItemTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBought => $composableBuilder(
      column: $table.isBought, builder: (column) => ColumnOrderings(column));
}

class $$ShoppingListItemTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTableTable> {
  $$ShoppingListItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isBought =>
      $composableBuilder(column: $table.isBought, builder: (column) => column);
}

class $$ShoppingListItemTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShoppingListItemTableTable,
    ShoppingListItemTableData,
    $$ShoppingListItemTableTableFilterComposer,
    $$ShoppingListItemTableTableOrderingComposer,
    $$ShoppingListItemTableTableAnnotationComposer,
    $$ShoppingListItemTableTableCreateCompanionBuilder,
    $$ShoppingListItemTableTableUpdateCompanionBuilder,
    (
      ShoppingListItemTableData,
      BaseReferences<_$AppDatabase, $ShoppingListItemTableTable,
          ShoppingListItemTableData>
    ),
    ShoppingListItemTableData,
    PrefetchHooks Function()> {
  $$ShoppingListItemTableTableTableManager(
      _$AppDatabase db, $ShoppingListItemTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListItemTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListItemTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListItemTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isBought = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShoppingListItemTableCompanion(
            id: id,
            name: name,
            isBought: isBought,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required bool isBought,
            Value<int> rowid = const Value.absent(),
          }) =>
              ShoppingListItemTableCompanion.insert(
            id: id,
            name: name,
            isBought: isBought,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ShoppingListItemTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ShoppingListItemTableTable,
        ShoppingListItemTableData,
        $$ShoppingListItemTableTableFilterComposer,
        $$ShoppingListItemTableTableOrderingComposer,
        $$ShoppingListItemTableTableAnnotationComposer,
        $$ShoppingListItemTableTableCreateCompanionBuilder,
        $$ShoppingListItemTableTableUpdateCompanionBuilder,
        (
          ShoppingListItemTableData,
          BaseReferences<_$AppDatabase, $ShoppingListItemTableTable,
              ShoppingListItemTableData>
        ),
        ShoppingListItemTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShoppingListItemTableTableTableManager get shoppingListItemTable =>
      $$ShoppingListItemTableTableTableManager(_db, _db.shoppingListItemTable);
}
