import 'package:flutter_bitkub_exchange/dao/order_detail/bitkub_order_information_history_dao.dart';

class BitkubOrderInformationDetailDao {
  int id;
  int first;
  int parent;
  int last;
  int amount;
  int rate;
  int fee;
  int credit;
  double filled;
  int total;
  String status;
  List<BitkubOrderInformationHistoryDao> history;

  BitkubOrderInformationDetailDao({this.id, this.first, this.parent, this.last, this.amount, this.rate, this.fee, this.credit, this.filled, this.total, this.status, this.history});

  BitkubOrderInformationDetailDao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first = json['first'];
    parent = json['parent'];
    last = json['last'];
    amount = json['amount'];
    rate = json['rate'];
    fee = json['fee'];
    credit = json['credit'];
    filled = json['filled'];
    total = json['total'];
    status = json['status'];
    if (json['history'] != null) {
      history = List<BitkubOrderInformationHistoryDao>();
      json['history'].forEach((v) {
        history.add(BitkubOrderInformationHistoryDao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['first'] = this.first;
    data['parent'] = this.parent;
    data['last'] = this.last;
    data['amount'] = this.amount;
    data['rate'] = this.rate;
    data['fee'] = this.fee;
    data['credit'] = this.credit;
    data['filled'] = this.filled;
    data['total'] = this.total;
    data['status'] = this.status;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
