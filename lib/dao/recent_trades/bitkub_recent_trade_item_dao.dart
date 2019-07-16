import 'package:flutter_bitkub_exchange/bitkub_trade_type.dart';

class BitkubRecentTradeItemDao {
  int timestamp;
  double rate;
  double amount;
  BitkubTradeType type;

  BitkubRecentTradeItemDao({this.timestamp, this.rate, this.amount, this.type});

  factory BitkubRecentTradeItemDao.fromJson(List<dynamic> list) {
    BitkubRecentTradeItemDao item = BitkubRecentTradeItemDao();
    item.timestamp = list[0];
    item.rate = double.parse(list[1].toString());
    item.amount = double.parse(list[2].toString());
    item.type = fromStringToBitkubTradeType(list[3]);

    return item;
  }

  Map<String, dynamic> toJson() {
    return {"timestamp": this.timestamp, "rate": this.rate, "amount": this.amount, "type": fromBitkubTradeTypeToString(type)};
  }
}
