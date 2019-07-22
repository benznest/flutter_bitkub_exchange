import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/user_open_order/bitkub_user_open_order_item_dao.dart';

class BitkubUserOpenOrderDao {
  List<BitkubUserOpenOrderItemDao> history;
  int error;
  String errorMessage;

  BitkubUserOpenOrderDao({this.history, this.error, this.errorMessage});

  isError() => error != 0;

  factory BitkubUserOpenOrderDao.fromJson(Map<String, dynamic> json) {
    List list = json["result"];
    return BitkubUserOpenOrderDao(
        error: json["error"],
        errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
        history: list?.map((i) => BitkubUserOpenOrderItemDao.fromJson(i))?.toList());
  }

  Map<String, dynamic> toJson() {
    return {"error": this.error, "errorMessage": this.errorMessage, "orders": this.history?.map((item) => item.toJson())?.toList()};
  }
}
