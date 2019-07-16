import 'package:flutter_bitkub_exchange/bitkub_trade_type.dart';

class BitkubOpenOrderItemDao {
  int timestamp;
  int orderId;
  double volume;
  double rate;
  double amount;

  BitkubOpenOrderItemDao({this.timestamp, this.orderId, this.rate, this.amount, this.volume});

  factory BitkubOpenOrderItemDao.fromJson(List<dynamic> list) {
    BitkubOpenOrderItemDao item = BitkubOpenOrderItemDao();
    item.orderId = list[0];
    item.timestamp = list[1];
    item.volume = double.parse(list[2].toString());
    item.rate = double.parse(list[3].toString());
    item.amount = double.parse(list[4].toString());

    return item;
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp": this.timestamp,
      "orderId": this.orderId,
      "volume": this.volume,
      "rate": this.rate,
      "amount": this.amount,
    };
  }
}
