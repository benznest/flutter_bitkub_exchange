class BitkubOrderInformationHistoryDao{
  double amount;
  double credit;
  double fee;
  int id;
  int rate;
  int timestamp;

  BitkubOrderInformationHistoryDao(
      {this.amount, this.credit, this.fee, this.id, this.rate, this.timestamp});

  BitkubOrderInformationHistoryDao.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    credit = json['credit'];
    fee = json['fee'];
    id = json['id'];
    rate = json['rate'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['credit'] = this.credit;
    data['fee'] = this.fee;
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['timestamp'] = this.timestamp;
    return data;
  }
}