import 'package:flutter/material.dart';

enum AddItemButtonState { loading, idle }

class AddItemButton extends StatelessWidget {
  final VoidCallback onTap;
  final AddItemButtonState buttonState;

  const AddItemButton({
    required this.onTap,
    this.buttonState = AddItemButtonState.idle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: onTap,
        child: buttonState == AddItemButtonState.idle
            ? const Icon(Icons.checklist)
            : const CircularProgressIndicator.adaptive(),
      );
}
