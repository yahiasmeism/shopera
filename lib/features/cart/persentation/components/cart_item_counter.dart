import 'package:flutter/material.dart';

class CartItemCounterWidget extends StatelessWidget {
  const CartItemCounterWidget({
    super.key,
    this.initalValue = 1,
    required this.onChange,
  });
  final int initalValue;
  final Function(int value) onChange;

  @override
  Widget build(BuildContext context) {
    int counter = initalValue;

    return Column(
      mainAxisSize: MainAxisSize.max,
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
            counter++;
            onChange(counter);
          },
        ),
        const SizedBox(height: 4),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
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
            if (counter > 1) {
              counter--;
              onChange(counter);
            }
          },
        ),
      ],
    );
  }
}
