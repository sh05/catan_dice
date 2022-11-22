import 'package:flutter/material.dart';

class DiceBody extends StatelessWidget {
  DiceBody({Key? key, required this.rolled}) : super(key: key);
  List<int> rolled = List.filled(2, 1);

  final List<String> redDiceImagePaths = [
    'assets/dice_red_1.png',
    'assets/dice_red_2.png',
    'assets/dice_red_3.png',
    'assets/dice_red_4.png',
    'assets/dice_red_5.png',
    'assets/dice_red_6.png',
  ];
  final List<String> blueDiceImagePaths = [
    'assets/dice_blue_1.png',
    'assets/dice_blue_2.png',
    'assets/dice_blue_3.png',
    'assets/dice_blue_4.png',
    'assets/dice_blue_5.png',
    'assets/dice_blue_6.png',
  ];

  @override
  Widget build(BuildContext context) {
    int result = rolled.reduce((int a, int b) => a + b);

    return Center(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            image: AssetImage(this.redDiceImagePaths[rolled[0] - 1]),
          ),
          Text(
            '$result',
            style: Theme.of(context).textTheme.headline1,
          ),
          Image(
            image: AssetImage(this.blueDiceImagePaths[rolled[1] - 1]),
          ),
        ],
      ),
    );
  }
}
