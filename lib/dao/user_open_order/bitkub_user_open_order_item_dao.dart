import 'package:flutter_bitkub_exchange/bitkub_open_order_side.dart';

class BitkubUserOpenOrderItemDao {
  int id;
  BitkubOpenOrderSide side;
  String type;
  double rate;
  double fee;
  double credit;
  double amount;
  double receive;
  int parentId;
  int superId;
  int ts;

  BitkubUserOpenOrderItemDao({this.id, this.side, this.type, this.rate, this.fee, this.credit, this.amount, this.receive, this.parentId, this.superId, this.ts});

  BitkubUserOpenOrderItemDao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    side = fromStringToBitkubOpenOrderSide(json['side']);
    type = json['type'];
    rate = double.parse(json['rate'].toString());
    fee = double.parse(json['fee'].toString());
    credit = double.parse(json['credit'].toString());
    amount = double.parse(json['amount'].toString());
    receive = double.parse(json['receive'].toString());
    parentId = json['parent_id'];
    superId = json['super_id'];
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['side'] = fromBitkubOpenOrderSideToString(this.side);
    data['type'] = this.type;
    data['rate'] = this.rate;
    data['fee'] = this.fee;
    data['credit'] = this.credit;
    data['amount'] = this.amount;
    data['receive'] = this.receive;
    data['parent_id'] = this.parentId;
    data['super_id'] = this.superId;
    data['ts'] = this.ts;
    return data;
  }
}
