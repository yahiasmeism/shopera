import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeleteItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DeleteItemButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      foregroundColor: const Color(0xffE90101),
      padding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEBEBEB),
      borderRadius: BorderRadius.circular(12),
      icon: Icons.delete_outline,
      spacing: 10,
      label: 'Delete',
      onPressed: (context) => onPressed(),
    );
  }
}
