
import '../../bitkub_open_order_side.dart';

class BitkubUserOrderHistoryItemDao {
  String txnId;
  int orderId;
  int parentOrderId;
  int superOrderId;
  bool takenByMe;
  BitkubOpenOrderSide side;
  String type;
  double rate;
  double fee;
  double credit;
  double amount;
  int ts;

  BitkubUserOrderHistoryItemDao(
      {this.txnId,
        this.orderId,
        this.parentOrderId,
        this.superOrderId,
        this.takenByMe,
        this.side,
        this.type,
        this.rate,
        this.fee,
        this.credit,
        this.amount,
        this.ts});

  BitkubUserOrderHistoryItemDao.fromJson(Map<String, dynamic> json) {
    txnId = json['txn_id'];
    orderId = json['order_id'];
    parentOrderId = json['parent_order_id'];
    superOrderId = json['super_order_id'];
    takenByMe = json['taken_by_me'];
    side = fromStringToBitkubOpenOrderSide(json['side']);
    type = json['type'];
    rate = double.parse(json['rate'].toString());
    fee = double.parse(json['fee'].toString());
    credit = double.parse(json['credit'].toString());
    amount = double.parse(json['amount'].toString());
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_id'] = this.txnId;
    data['order_id'] = this.orderId;
    data['parent_order_id'] = this.parentOrderId;
    data['super_order_id'] = this.superOrderId;
    data['taken_by_me'] = this.takenByMe;
    data['side'] = fromBitkubOpenOrderSideToString(this.side);
    data['type'] = this.type;
    data['rate'] = this.rate;
    data['fee'] = this.fee;
    data['credit'] = this.credit;
    data['amount'] = this.amount;
    data['ts'] = this.ts;
    return data;
  }
}
