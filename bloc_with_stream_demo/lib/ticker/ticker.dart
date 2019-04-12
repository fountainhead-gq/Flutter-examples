import 'dart:async';

class Ticker {
  Stream<int> tick() {
    DateTime now = DateTime.now();
    // DateTime dDay = DateTime(
    //     now.year, now.month, now.day, now.hour, now.minute, now.second + 60);

    var dDay = now.add(new Duration(seconds: 60));

    return Stream.periodic(Duration(seconds: 1), (x) {
      print(x);
      return x;
    }).take(dDay.second);
  }
}
