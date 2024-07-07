import 'package:flutter/material.dart';

abstract class SnackBarGlobal {
  static var key = GlobalKey<ScaffoldMessengerState>();

  static void show(BuildContext context, String text,
      {Color? color, IconData? icon}) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          content: Row(
            children: [
              icon == null
                  ? const SizedBox()
                  : Row(
                      children: [
                        Icon(icon, color: Colors.white, size: 40),
                        const SizedBox(width: 20),
                      ],
                    ),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )),
            ],
          ),
        ),
      );
  }
}
