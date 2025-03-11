import 'package:flutter/material.dart';
import 'package:shopping_list_demo/widget/add_item_page.dart';

import '../di/app_dependencies.dart';
import '../domain/manager/shopping_list_manager.dart';
import '../domain/manager/shopping_list_state.dart';
import 'add_item_button.dart';
import 'error_snack_bar.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  late final ShoppingListManager manager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Берём менеджер из зависимостей
    manager = AppDependencies.of(context).shoppingListManager;

    // Подписываемся на уведомления
    manager.addListener(_onManagerUpdated);

    // Загружаем список при первом запуске экрана
    manager.loadItems();
  }

  @override
  void dispose() {
    manager.removeListener(_onManagerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = manager.state;
    final items = manager.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Builder(
        builder: (_) {
          if (state == ShoppingListState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (items.isEmpty) {
            return const Center(child: Text('No items yet'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return ListTile(
                leading: Checkbox(
                  value: item.isBought,
                  onChanged: (_) => _onToggleBought(item.id),
                ),
                title: Text(
                  item.name,
                  style: TextStyle(
                    decoration: item.isBought
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _onRemoveItem(item.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: AddItemButton(
        buttonState: _buttonState(state),
        onTap: _onAddNewItem,
      ),
    );
  }

  void _onManagerUpdated() {
    setState(() {});

    if (manager.state == ShoppingListState.itemChangeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          text: 'Failed to toggle item',
        ),
      );
    }

    if (manager.state == ShoppingListState.itemDeleteError) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          text: 'Failed to delete item',
        ),
      );
    }
  }

  Future<void> _onAddNewItem() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddItemPage(),
      ),
    );
    if (result != null && result.isNotEmpty) {
      await manager.addItem(result);
    }
  }

  void _onToggleBought(String id) {
    manager.toggleBought(id);
  }

  void _onRemoveItem(String id) {
    manager.removeItem(id);
  }

  AddItemButtonState _buttonState(ShoppingListState shoppingListState) {
    if (shoppingListState == ShoppingListState.itemSaveProgress) {
      return AddItemButtonState.loading;
    }

    return AddItemButtonState.idle;
  }
}
