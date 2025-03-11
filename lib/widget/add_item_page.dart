import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('text_field'),
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Item name',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSave,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    final text = _controller.text.trim();
    // Закрываем экран и возвращаем текст
    Navigator.pop(context, text);
  }
}
