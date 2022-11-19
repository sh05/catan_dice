import 'package:flutter/material.dart';

class MyHomePageFab extends StatelessWidget {
  MyHomePageFab({Key? key, this.roll}) : super(key: key);
  final VoidCallback? roll;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: roll,
      child: const Icon(Icons.casino, size: 160),
    );
  }
}
