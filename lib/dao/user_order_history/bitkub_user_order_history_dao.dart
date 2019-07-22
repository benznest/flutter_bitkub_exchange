import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/user_order_history/bitkub_user_order_history_item_dao.dart';
import 'package:flutter_bitkub_exchange/dao/user_order_history/bitkub_user_order_history_pagination_dao.dart';

class BitkubUserOrderHistoryDao {
  List<BitkubUserOrderHistoryItemDao> history;
  BitkubUserOrderHistoryPaginationDao pagination;
  int error;
  String errorMessage;

  BitkubUserOrderHistoryDao({this.history, this.pagination, this.error, this.errorMessage});

  isError() => error != 0;

  factory BitkubUserOrderHistoryDao.fromJson(Map<String, dynamic> json) {
    List list = json["result"];

    if(list != null){
      return BitkubUserOrderHistoryDao(
          error: json["error"],
          errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
          history: list?.map((i) => BitkubUserOrderHistoryItemDao.fromJson(i))?.toList() ?? List(),
          pagination: BitkubUserOrderHistoryPaginationDao.fromJson(json["pagination"]));
    }else{
      return BitkubUserOrderHistoryDao(
          error: json["error"],
          errorMessage: BitkubErrorManager.getErrorMessage(json["error"]));
    }

  }

  Map<String, dynamic> toJson() {
    return {"error": this.error, "errorMessage": this.errorMessage, "orders": this.history?.map((item) => item.toJson())?.toList(), "pagination": pagination?.toJson()};
  }
}
