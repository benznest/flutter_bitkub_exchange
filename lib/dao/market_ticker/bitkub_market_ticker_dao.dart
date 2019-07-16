import 'package:flutter_bitkub_exchange/bitkub_pair_currency_manager.dart';
import 'package:flutter_bitkub_exchange/dao/market_ticker/bitkub_pair_currency_data_dao.dart';

class BitkubMarketTickerDao {
  List<BitkubPairCurrencyDataDao> list;

  BitkubMarketTickerDao({this.list});

  factory BitkubMarketTickerDao.fromJson(Map<String, dynamic> json) {
    List<BitkubPairCurrencyDataDao> list = List();
    for (String pairName in BitkubPairCurrencyManager.PAIR_CURRENCY_AVAILABLE) {
      if(json[pairName] != null) {
        list.add(BitkubPairCurrencyDataDao.fromJson(pairName, json[pairName]));
      }
    }

    return BitkubMarketTickerDao(list: list);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for (BitkubPairCurrencyDataDao pairCurrency in list) {
      data[pairCurrency.pairName] = pairCurrency.toJson();
    }
    return data;
  }
}
