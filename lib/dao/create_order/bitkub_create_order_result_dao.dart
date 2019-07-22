import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/create_order/bitkub_create_order_result_detail_dao.dart';

class BitkubCreateOrderResultDao {
  int error;
  String errorMessage;
  BitkubCreateOrderResultDetailDao detail;

  BitkubCreateOrderResultDao({this.error, this.errorMessage, this.detail});

  isError() => error != 0;

  factory BitkubCreateOrderResultDao.fromJson(Map<String, dynamic> json) {
    return BitkubCreateOrderResultDao(
      error: int.parse(json["error"].toString()),
      errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
      detail: json["result"] != null ? BitkubCreateOrderResultDetailDao.fromJson(json["result"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": this.error,
      "errorMessage": this.errorMessage,
      "detail": this.detail,
    };
  }
}
