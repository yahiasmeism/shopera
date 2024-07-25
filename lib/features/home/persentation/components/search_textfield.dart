import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(dynamic value) onChanged;
  final VoidCallback onClear; // New callback to clear search

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = FocusNode();

    _controller.addListener(() {
      setState(() {});
    });
  }

  void _unfocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.teal),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _unfocus();
                  widget.onClear(); // Invoke clear callback
                },
              )
            : null,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        widget.onChanged(value); // Propagate onChanged callback
      },
      onSubmitted: (value) {
        _unfocus();
      },
    );
  }
}
