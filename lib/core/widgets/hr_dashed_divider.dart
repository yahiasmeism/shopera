import 'package:flutter/material.dart';

class HrDashedDivider extends StatelessWidget {
  final int dashSize;
  final double height;
  final Color color;
  final int indent;
  final int endIndent;
  const HrDashedDivider({
    super.key,
    this.dashSize = 1,
    this.height = 1,
    this.color = Colors.grey,
    this.indent = 0,
    this.endIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: indent.toDouble(),
        right: endIndent.toDouble(),
      ),
      child: Row(
        children: List.generate(
          150 ~/ dashSize,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : color,
              height: height,
            ),
          ),
        ),
      ),
    );
  }
}
