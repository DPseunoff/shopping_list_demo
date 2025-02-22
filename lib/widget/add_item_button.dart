import 'package:flutter/material.dart';

enum AddItemButtonState { loading, idle }

class AddItemButton extends StatelessWidget {
  final AddItemButtonState buttonState;
  final VoidCallback? onTap;

  const AddItemButton({
    this.buttonState = AddItemButtonState.idle,
    this.onTap,
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
