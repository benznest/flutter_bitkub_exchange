import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/create_order/bitkub_create_order_result_detail_dao.dart';

class BitkubCancelOrderResultDao {
  int error;
  String errorMessage;

  BitkubCancelOrderResultDao({this.error, this.errorMessage});

  isSuccess() => error == 0;

  isError() => error != 0;

  factory BitkubCancelOrderResultDao.fromJson(Map<String, dynamic> json) {
    return BitkubCancelOrderResultDao(
      error: int.parse(json["error"].toString()),
      errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": this.error,
      "errorMessage": this.errorMessage,
    };
  }
}
