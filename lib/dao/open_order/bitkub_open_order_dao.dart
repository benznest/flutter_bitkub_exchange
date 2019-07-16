import 'dart:convert';

import 'package:flutter_bitkub_exchange/bitkub_open_order_type.dart';
import 'package:flutter_bitkub_exchange/dao/open_order/bitkub_open_order_item_dao.dart';
import 'package:flutter_bitkub_exchange/dao/recent_trades/bitkub_recent_trade_item_dao.dart';

class BitkubOpenOrderDao {
  BitkubOpenOrderType orderType;
  int errorCode;
  List<BitkubOpenOrderItemDao> orders;
  List<String> errorMessage;

  BitkubOpenOrderDao({this.orderType, this.errorCode, this.orders, this.errorMessage});

  bool isError() {
    return errorCode != 0;
  }

  factory BitkubOpenOrderDao.fromJson(BitkubOpenOrderType orderType, Map<String, dynamic> json) {
    if (json["error"] == 0) {
      return BitkubOpenOrderDao(
        orderType: orderType,
        errorCode: json["error"],
        errorMessage: List(),
        orders: List.of(json["result"]).map((json) => BitkubOpenOrderItemDao.fromJson(json)).toList(),
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
      return BitkubOpenOrderDao(orderType: orderType, errorCode: json["error"], errorMessage: listError, orders: List());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "orderType":fromBitkubOpenOrderTypeToString(orderType),
      "error": this.errorCode,
      "result": this.orders.map((item) => item.toJson()).toList(),
      "errorMessage": this.errorMessage.map((item) => item).toList()
    };
  }
}
