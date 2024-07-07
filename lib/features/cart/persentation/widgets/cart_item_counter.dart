import 'package:flutter/material.dart';

class CartItemCounterWidget extends StatefulWidget {
  const CartItemCounterWidget({
    super.key,
    this.initalValue = 1,
    required this.onChange,
  });
  final int initalValue;
  final Function(int value) onChange;
  @override
  State<CartItemCounterWidget> createState() => _CartItemCounterWidgetState();
}

class _CartItemCounterWidgetState extends State<CartItemCounterWidget> {
  late int counter;
  @override
  void initState() {
    counter = widget.initalValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withOpacity(.1)),
            ),
            child: const Icon(Icons.add, size: 20),
          ),
          onTap: () {
            setState(() {
              counter++;
              widget.onChange(counter);
            });
          },
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black.withOpacity(.1)),
              ),
              child: const Icon(
                size: 20,
                Icons.remove_outlined,
              )),
          onTap: () {
            setState(() {
              if (counter > 1) {
                counter--;
                widget.onChange(counter);
              }
            });
          },
        ),
      ],
    );
  }
}
