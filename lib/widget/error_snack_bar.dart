import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  final String text;

  ErrorSnackBar({
    required this.text,
    super.key,
  }) : super(
          content: Text(text),
          duration: const Duration(seconds: 1),
        );
}
