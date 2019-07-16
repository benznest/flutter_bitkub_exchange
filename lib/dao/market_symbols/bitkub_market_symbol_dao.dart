import 'dart:convert';

import 'package:flutter_bitkub_exchange/dao/market_symbols/bitkub_market_symbol_item_dao.dart';

class BitkubMarketSymbolDao {
  int error;
  List<BitkubMarketSymbolItemDao> result;

  BitkubMarketSymbolDao({this.error, this.result});

  factory BitkubMarketSymbolDao.fromJson(Map<String, dynamic> json) {
    List list = json["result"];

    BitkubMarketSymbolDao response = BitkubMarketSymbolDao();
    response.error = json["error"];
    response.result = list.map((json) => BitkubMarketSymbolItemDao.fromJson(json)).toList();

    return response;
  }

  Map<String, dynamic> toJson() {
    return {
      "error": this.error,
      "result": this.result.map((item) => item.toJson()).toList(),
    };
  }
}
