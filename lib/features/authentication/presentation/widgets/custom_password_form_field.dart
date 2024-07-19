import 'package:flutter/material.dart';
import 'text_form_field.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    
    required this.controller,
  });
  final TextEditingController controller;
  
  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: widget.controller,
      type: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      label: 'Enter your password',
      prefix: Icons.lock,
      suffix:  _obscureText ? Icons.visibility_off : Icons.visibility,

      isPassword: _obscureText,
      suffixPressed: () {
       setState(() {
              _obscureText = !_obscureText;
            });

      },
    );
  }
}
