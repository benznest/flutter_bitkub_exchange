import 'package:flutter_bitkub_exchange/bitkub_error_manager.dart';
import 'package:flutter_bitkub_exchange/dao/order_detail/bitkub_order_information_detail_dao.dart';

class BitkubOrderInformationDao {
  BitkubOrderInformationDetailDao detail;
  int error;
  String errorMessage;

  BitkubOrderInformationDao({this.detail, this.error, this.errorMessage});

  isError() => error != 0;

  factory BitkubOrderInformationDao.fromJson(Map<String, dynamic> json) {
      return BitkubOrderInformationDao(
          error: json["error"],
          errorMessage: BitkubErrorManager.getErrorMessage(json["error"]),
          detail: BitkubOrderInformationDetailDao.fromJson(json["result"]));

  }

  Map<String, dynamic> toJson() {
    return {"error": this.error, "errorMessage": this.errorMessage, "result": this.detail?.toJson()};
  }
}

