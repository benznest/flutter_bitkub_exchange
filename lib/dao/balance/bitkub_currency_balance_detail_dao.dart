class BitkubCurrencyBalanceDetailDao {
  double available;
  double reserved;

  BitkubCurrencyBalanceDetailDao({this.available, this.reserved});

   double get balance => available+reserved;

  factory BitkubCurrencyBalanceDetailDao.fromJson(Map<String, dynamic> json) {
    return BitkubCurrencyBalanceDetailDao(
      available: double.parse(json["available"].toString()),
      reserved: double.parse(json["reserved"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "available": this.available,
      "reserved": this.reserved,
    };
  }
}
