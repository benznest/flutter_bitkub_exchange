class BitkubCreateOrderResultDetailDao{
  int id;
  String type;
  double amount;
  double rate;
  double fee;
  double credit;
  double receive;
  int timestamp;


  BitkubCreateOrderResultDetailDao(
      {this.id,
        this.type,
        this.amount,
        this.rate,
        this.fee,
        this.credit,
        this.receive,
        this.timestamp});


  BitkubCreateOrderResultDetailDao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['typ'];
    amount = double.parse(json['amt'].toString());
    rate = double.parse(json['rat'].toString());
    fee = double.parse(json['fee'].toString());
    credit = double.parse(json['cre'].toString());
    receive = double.parse(json['rec'].toString());
    timestamp = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typ'] = this.type;
    data['amt'] = this.amount;
    data['rat'] = this.rate;
    data['fee'] = this.fee;
    data['cre'] = this.credit;
    data['rec'] = this.receive;
    data['ts'] = this.timestamp;
    return data;
  }
}