import 'dart:math' as math;

// void main() {
//   List<String> players = ['Bob', 'John', 'Alice'];

//   CatanDice cdice = CatanDice();
//   print(players[cdice.history.length % players.length] + "'s turn!'");
//   print(cdice.roll());

//   print(players[cdice.history.length % players.length] + "'s turn!'");
//   print(cdice.roll());

//   print(players[cdice.history.length % players.length] + "'s turn!'");
//   print(cdice.roll());

//   print(players[cdice.history.length % players.length] + "'s turn!'");
//   print(cdice.roll());

//   print(players[cdice.history.length % players.length] + "'s turn!'");
//   print(cdice.roll());

//   print(cdice.history);
//   print(cdice.getDistribution());
// }

class CatanDice {
  List<List<int>> history = [];

  List<int> roll() {
    int diceA = math.Random().nextInt(5) + 1;
    int diceB = math.Random().nextInt(5) + 1;
    List<int> result = [diceA, diceB];
    this.history.add(result);
    return [diceA, diceB];
  }

  List<int> getDistribution() {
    // first two elements are not used. (2-12)
    List<int> distribution = List.filled(13, 0);
    // なんかformatがこうしたがる
    this
        .history
        .forEach((List<int> rolled) => distribution[rolled[0] + rolled[1]]++);
    return distribution;
  }

  int getHistoryLength() {
    return this.history.length;
  }
}