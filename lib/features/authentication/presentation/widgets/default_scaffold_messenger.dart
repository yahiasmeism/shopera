import 'package:flutter/material.dart';

class DefaultScaffoldMessenger {
  final BuildContext context;
  final String message;
  DefaultScaffoldMessenger({required this.context, required this.message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
