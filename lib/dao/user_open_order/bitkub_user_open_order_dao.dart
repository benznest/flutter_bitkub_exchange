import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/user_open_order/bitkub_user_open_order_item_dao.dart';

class BitkubUserOpenOrderDao {
  List<BitkubUserOpenOrderItemDao> orders;
  int error;
  String errorMessage;

  BitkubUserOpenOrderDao({this.orders, this.error, this.errorMessage});

  isError() => error != 0;

  factory BitkubUserOpenOrderDao.fromJson(Map<String, dynamic> json) {
    List list = json["result"];
    return BitkubUserOpenOrderDao(
        error: json["error"],
        errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
        orders: list?.map((i) => BitkubUserOpenOrderItemDao.fromJson(i))?.toList());
  }

  Map<String, dynamic> toJson() {
    return {"error": this.error, "errorMessage": this.errorMessage, "orders": this.orders?.map((item) => item.toJson())?.toList()};
  }
}
