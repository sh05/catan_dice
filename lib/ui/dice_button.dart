import 'package:flutter/material.dart';
import 'dart:math';

class DiceButton extends StatelessWidget {
  DiceButton({Key? key, this.roll}) : super(key: key);
  final VoidCallback? roll;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: roll,
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Transform.rotate(
          angle: 3 * pi / 2, //60度
          child: const Icon(Icons.redo, size: 160),
        ),
        const Icon(Icons.casino, size: 160),
        Transform.rotate(
          angle: pi / 2, //60度
          child: const Icon(Icons.redo, size: 160),
        ),
      ]),
    );
  }
}
