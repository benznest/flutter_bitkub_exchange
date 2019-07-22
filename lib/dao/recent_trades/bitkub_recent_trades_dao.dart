import 'dart:convert';

import 'package:flutter_bitkub_exchange/dao/recent_trades/bitkub_recent_trade_item_dao.dart';

class BitkubRecentTradesDao {
  int errorCode;
  List<BitkubRecentTradeItemDao> items;
  List<String> errorMessage;

  BitkubRecentTradesDao({this.errorCode, this.items, this.errorMessage});

  bool isError() {
    return errorCode != 0;
  }

  factory BitkubRecentTradesDao.fromJson(Map<String, dynamic> json) {
    if (json["error"] == 0) {
      return BitkubRecentTradesDao(
        errorCode: json["error"],
        errorMessage: List(),
        items: List.of(json["result"]).map((json) => BitkubRecentTradeItemDao.fromJson(json)).toList(),
      );
    } else {
      var jsonResult = json["result"];
      List<String> listError = List();
      if (json["result"] != null) {
        jsonResult["sym"] ?? listError.addAll(jsonResult["sym"]);
        jsonResult["lmt"] ?? listError.addAll(jsonResult["lmt"]);
      }else{
        listError.add("There are no symbol trade.");
      }
      return BitkubRecentTradesDao(errorCode: json["error"], errorMessage: listError, items: List());
    }
  }

  Map<String, dynamic> toJson() {
    return {"error": this.errorCode, "result": this.items.map((item) => item.toJson()).toList(),
      "errorMessage": this.errorMessage.map((item)=>item).toList()};
  }
}
