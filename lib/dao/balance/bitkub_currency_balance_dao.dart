import 'package:flutter_bitkub_exchange/dao/balance/bitkub_currency_balance_detail_dao.dart';

class BitkubCurrencyBalanceDao {
  String symbol;
  double balance;
  BitkubCurrencyBalanceDetailDao detail;

  BitkubCurrencyBalanceDao({this.symbol, this.balance, this.detail});

  Map<String, dynamic> toJson() {
    return {"symbol": this.symbol, "balance": this.balance, "detail": detail.toJson()};
  }
}
