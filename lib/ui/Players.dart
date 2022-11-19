import 'package:flutter/material.dart';

class PlayersWidget extends StatelessWidget {
  PlayersWidget({Key? key, required this.historyLength}) : super(key: key);
  int historyLength = 0;
  List<String> _players = ["Bob", "John", "Alice"];

  @override
  Widget build(BuildContext context) {
    String nextPlayer = "";
    if (this._players.length > 0) {
      nextPlayer = this._players[this.historyLength % this._players.length];
    }

    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "参加者をカンマ区切りで入力してください",
          ),
          onChanged: (text) {
            if (text.length > 0) {
              this._players = text.split(",");
            }
          },
        ),
        Text("次は" + "$nextPlayer" + "さんの番です"),
      ],
    );
  }
}
