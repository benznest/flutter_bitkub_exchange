import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/bitkub_pair_currency_manager.dart';
import 'package:flutter_bitkub_exchange/dao/balance/bitkub_currency_balance_dao.dart';
import 'package:flutter_bitkub_exchange/dao/balance/bitkub_currency_balance_detail_dao.dart';

class BitkubWalletBalanceDao {
  int error;
  String errorMessage;
  List<BitkubCurrencyBalanceDao> wallet;

  isError() => error != 0;

  BitkubWalletBalanceDao({this.error, this.errorMessage, this.wallet});

  factory BitkubWalletBalanceDao.fromJson(Map<String, dynamic> json) {
    List<BitkubCurrencyBalanceDao> listCurrencyBalance = List();
    var result = json["result"];
    if (result != null) {
      for (String symbol in BitkubCurrency.WALLET_CURRENCY_AVAILABLE) {
        if (result[symbol] != null) {
          BitkubCurrencyBalanceDetailDao detail = BitkubCurrencyBalanceDetailDao.fromJson(result[symbol]);

          double balance = detail.balance;
          BitkubCurrencyBalanceDao currencyBalance = BitkubCurrencyBalanceDao(currency: symbol, balance: balance, detail: detail);
          listCurrencyBalance.add(currencyBalance);
        }
      }
    }

    return BitkubWalletBalanceDao(
      error: json["error"],
      errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
      wallet: listCurrencyBalance,
    );
  }

  Map<String, dynamic> toJson() {
    return {"error": this.error, "errorMessage": this.errorMessage, "wallet": wallet.map((item) => item.toJson()).toList()};
  }
}
