import 'package:flutter_bitkub_exchange/dao/balance/bitkub_currency_balance_detail_dao.dart';

class BitkubCurrencyBalanceDao {
  String currency;
  double balance;
  BitkubCurrencyBalanceDetailDao detail;

  BitkubCurrencyBalanceDao({this.currency, this.balance, this.detail});

  Map<String, dynamic> toJson() {
    return {"symbol": this.currency, "balance": this.balance, "detail": detail.toJson()};
  }
}
