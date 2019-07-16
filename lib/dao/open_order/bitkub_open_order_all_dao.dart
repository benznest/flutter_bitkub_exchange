import 'dart:convert';

import 'package:flutter_bitkub_exchange/bitkub_open_order_type.dart';
import 'package:flutter_bitkub_exchange/dao/open_order/bitkub_open_order_item_dao.dart';
import 'package:flutter_bitkub_exchange/dao/recent_trades/bitkub_recent_trade_item_dao.dart';

class BitkubOpenOrderAllDao {
  int errorCode;
  List<BitkubOpenOrderItemDao> bids;
  List<BitkubOpenOrderItemDao> asks;
  List<String> errorMessage;

  BitkubOpenOrderAllDao({this.errorCode, this.bids, this.asks, this.errorMessage});

  bool isError() {
    return errorCode != 0;
  }

  factory BitkubOpenOrderAllDao.fromJson( Map<String, dynamic> json) {
    if (json["error"] == 0) {
      return BitkubOpenOrderAllDao(
        errorCode: json["error"],
        errorMessage: List(),
        bids: List.of(json["result"]["bids"]).map((json) => BitkubOpenOrderItemDao.fromJson(json)).toList(),
        asks: List.of(json["result"]["asks"]).map((json) => BitkubOpenOrderItemDao.fromJson(json)).toList(),
      );
    } else {
      var jsonResult = json["result"];
      List<String> listError = List();
      if (json["result"] != null) {
        jsonResult["sym"] ?? listError.addAll(jsonResult["sym"]);
        jsonResult["lmt"] ?? listError.addAll(jsonResult["lmt"]);
      } else {
        listError.add("There are no symbol trade.");
      }
      return BitkubOpenOrderAllDao( errorCode: json["error"], errorMessage: listError, bids: List(), asks: List());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "error": this.errorCode,
      "result": {"bids": this.bids.map((item) => item.toJson()).toList(), "asks": this.asks.map((item) => item.toJson()).toList()},
      "errorMessage": this.errorMessage.map((item) => item).toList()
    };
  }
}
