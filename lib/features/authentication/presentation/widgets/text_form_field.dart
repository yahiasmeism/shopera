import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validator;
  final String? label;
  final IconData prefix;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final bool isPassword;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final bool isClickable;
  final void Function()? onTap;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.type,
    required this.validator,
    required this.label,
    required this.prefix,
    this.onSubmitted,
    this.onChanged,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      validator: validator,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border:const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
      ),
    );
  }
}
