import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'ui/MyHomePageBody.dart';
import 'ui/MyHomePageFab.dart';
import 'ui/Histgram.dart';
import 'script/CatanDice.dart';

class CatanDiceApp extends StatelessWidget {
  const CatanDiceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Catan Dice",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CatanDicePage(title: "Catan Dice"),
    );
  }
}

class CatanDicePage extends StatefulWidget {
  const CatanDicePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CatanDicePage> createState() => _CatanDicePageState();
}

class _CatanDicePageState extends State<CatanDicePage> {
  CatanDice cdice = CatanDice();
  List<int> _rolled = List.filled(2, 1);
  final FlutterTts tts = FlutterTts();
  List<String> _players = ["Bob", "John", "Alice"];

  void _roll() {
    setState(() {
      this._rolled = this.cdice.roll();
      int result = this._rolled.reduce((int a, int b) => a + b);
      this.tts.speak(result.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 200;
    String nextPlayer = "";
    if (this._players.length > 0) {
      nextPlayer =
          this._players[this.cdice.getHistoryLength() % this._players.length];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: <Widget>[
            MyHomePageBody(rolled: this._rolled),
          ]),

          // 参加者管理 state管理するのめんどくさいのでここに書く
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyChart(distribution: this.cdice.getDistribution()),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "参加者をカンマ区切りで入力してください",
                ),
                onChanged: (text) {
                  if (text.length > 0) {
                    setState(() {
                      this._players = text.split(",");
                    });
                  }
                },
              ),
              Text(
                "次は" + "$nextPlayer" + "さんの番です",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: MyHomePageFab(roll: this._roll),
        ),
      ),
    );
  }
}
