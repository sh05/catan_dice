import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'ui/dice_body.dart';
import 'ui/dice_button.dart';
import 'ui/histgram.dart';
import 'script/catandice.dart';

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
  final audioPlayer = AudioPlayer();
  List<int> _rolled = List.filled(2, 1);
  final FlutterTts tts = FlutterTts();
  List<String> _players = ["Bob", "John", "Alice"];

  @override
  void initState() {
    super.initState();
    this._loadAudioFile();

    // 読み上げとヨン！のバランスを取る
    audioPlayer.setVolume(1.0);
    tts.setVolume(0.2);
  }

  _loadAudioFile() {
    audioPlayer.setAsset('assets/yon_dog.mp3');
  }

  void _roll() {
    setState(() {
      this._rolled = this.cdice.roll();
      int result = this._rolled.reduce((int a, int b) => a + b);

      if (result == 4) {
        audioPlayer.play();
        this._loadAudioFile();
      } else {
        tts.speak(result.toString());
      }
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
            DiceBody(rolled: this._rolled),
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
          child: DiceButton(roll: this._roll),
        ),
      ),
    );
  }
}
