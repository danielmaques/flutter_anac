import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final color;
  final String text;

  Indicator({
    this.color,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
        ),
        SizedBox(width: 15),
        Text(text),
      ],
    );
  }
}
