import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bitkub_exchange/bitkub_auth_utils.dart';
import 'package:flutter_bitkub_exchange/bitkub_open_order_side.dart';
import 'package:flutter_bitkub_exchange/bitkub_open_order_type.dart';
import 'package:flutter_bitkub_exchange/bitkub_utils.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:flutter_bitkub_exchange/dao/balance/bitkub_wallet_balance_dao.dart';
import 'package:flutter_bitkub_exchange/dao/bitkub_server_time_dao.dart';
import 'package:flutter_bitkub_exchange/dao/cancel_order/bitkub_cancel_order_result_dao.dart';
import 'package:flutter_bitkub_exchange/dao/create_order/bitkub_create_order_result_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_symbols/bitkub_market_symbol_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_ticker/bitkub_market_ticker_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_open_order/bitkub_market_open_order_all_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_open_order/bitkub_market_open_order_dao.dart';
import 'package:flutter_bitkub_exchange/dao/order_detail/bitkub_order_information_dao.dart';
import 'package:flutter_bitkub_exchange/dao/recent_trades/bitkub_recent_trades_dao.dart';
import 'package:flutter_bitkub_exchange/dao/user_open_order/bitkub_user_open_order_dao.dart';
import 'package:flutter_bitkub_exchange/dao/user_order_history/bitkub_user_order_history_dao.dart';
import 'package:http/http.dart' as http;

class BitkubExchangeService {
  static const String BASE_URL = "api.bitkub.com";
  static const String POINT_API = "api/";

  /// Header content-type
  static const String FORM_URL_ENCODED = "application/x-www-form-urlencoded";

  /// Public API
  static const String END_POINT_SERVER_TIME = "servertime/";
  static const String END_POINT_MARKET_SYMBOLS = "market/symbols/";
  static const String END_POINT_MARKET_TICKER = "market/ticker/";
  static const String END_POINT_MARKET_RECENT_TRADE = "market/trades/";
  static const String END_POINT_OPEN_ORDER_BIDS = "market/bids/";
  static const String END_POINT_OPEN_ORDER_ASKS = "market/asks/";
  static const String END_POINT_OPEN_ORDER_ALL = "market/books/";

  /// Private API
  static const String END_POINT_WALLET_BALANCE = "market/balances/";
  static const String END_POINT_OPEN_ORDER = "market/my-open-orders/";
  static const String END_POINT_ORDER_HISTORY = "market/my-order-history/";
  static const String END_POINT_ORDER_INFORMATION = "market/order-info/";
  static const String END_POINT_CREATE_BUY_ORDER = "market/place-bid/";
  static const String END_POINT_CREATE_SELL_ORDER = "market/place-ask/";
  static const String END_POINT_CANCEL_ORDER = "market/cancel-order/";

  ///
  /// Api key for get general data.
  /// Required permission
  /// [Balances] for get data balance and transaction history.
  /// [Deposit] for get deposit address on wallet.
  /// Recommend [disable] 2FA on this key.
  ///
  BitkubApiKey apiKeyGeneral;

  ///
  /// Api key for creating order.
  /// Required permission
  /// [CreateOrder] for creating order.
  /// Recommend [enable] 2FA on this key for more security.
  ///
  BitkubApiKey apiKeyCreateOrder;

  ///
  /// Api key for canceling order.
  /// Required permission
  /// [CancelOrder] for canceling order.
  /// Recommend [enable] 2FA on this key for more security.
  ///
  BitkubApiKey apiKeyCancelOrder;

  BitkubExchangeService({this.apiKeyGeneral, this.apiKeyCreateOrder, this.apiKeyCancelOrder});

  /// This is a [public] api.
  /// Get server timestamp.
  Future<BitKubServerTimeDao> fetchServerTime({bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_SERVER_TIME).toString();
    http.Response response = await http.get(url);
    int serverTime = int.parse(response.body);

    BitKubServerTimeDao dao = BitKubServerTimeDao(serverTime: serverTime);
    if (printJson) {
      print(url);
      printPrettyJson(dao.toJson());
    }
    return dao;
  }

  /// This is a [public] api.
  /// Get List all available symbols.
  Future<BitkubMarketSymbolDao> fetchMarketSymbols({bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_MARKET_SYMBOLS).toString();
    var response = await http.get(url);
    var responseJson = decodeJsonUtf8(response);

    BitkubMarketSymbolDao marketSymbols = BitkubMarketSymbolDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(marketSymbols.toJson());
    }
    return marketSymbols;
  }

  /// This is a [public] api.
  /// Get ticker information.
  Future<BitkubMarketTickerDao> fetchMarketTicker({String currency = "", bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_MARKET_TICKER, {"sym": "$currency"}).toString();
    var response = await http.get(url);
    var responseJson = decodeJsonUtf8(response);

    BitkubMarketTickerDao marketTicker = BitkubMarketTickerDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(marketTicker.toJson());
    }

    return marketTicker;
  }

  /// This is a [public] api.
  /// Get list recent trades.
  Future<BitkubRecentTradesDao> fetchRecentTrades({String currency = "THB_BTC", int limit = 100, bool printJson = false}) async {
    assert(limit != null && limit > 0, "Please provide limit of data.");
    assert(currency != null && currency.isNotEmpty, "Please provide pair symbol of data.");

    String url = Uri.https(BASE_URL, POINT_API + END_POINT_MARKET_RECENT_TRADE, {"sym": "$currency", "lmt": "$limit"}).toString();
    var response = await http.get(url);
    var responseJson = decodeJsonUtf8(response);

    BitkubRecentTradesDao recentTrades = BitkubRecentTradesDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(recentTrades.toJson());
    }

    return recentTrades;
  }

  /// This is a [public] api.
  /// Get list open buy orders.
  Future<BitkubMarketOpenOrderDao> fetchMarketOpenOrders({@required BitkubOpenOrderType orderType,@required String currency, int limit = 100, bool printJson = false}) async {
    assert(limit != null && limit > 0, "Please provide limit of data.");
    assert(currency != null && currency.isNotEmpty, "Please provide pair symbol of data.");

    String endpoint = "";
    if (orderType == BitkubOpenOrderType.BIDS) {
      endpoint = END_POINT_OPEN_ORDER_BIDS;
    } else {
      endpoint = END_POINT_OPEN_ORDER_ASKS;
    }

    String url = Uri.https(BASE_URL, POINT_API + endpoint, {"sym": "$currency", "lmt": "$limit"}).toString();
    var response = await http.get(url);
    var responseJson = decodeJsonUtf8(response);

    BitkubMarketOpenOrderDao openOrder = BitkubMarketOpenOrderDao.fromJson(orderType, responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(openOrder.toJson());
    }

    return openOrder;
  }

  /// This is a [public] api.
  /// Get all open orders.
  Future<BitkubMarketOpenOrderAllDao> fetchMarketOpenOrdersAll({String currency = "THB_BTC", int limit = 100, bool printJson = false}) async {
    assert(limit != null && limit > 0, "Please provide limit of data.");
    assert(currency != null && currency.isNotEmpty, "Please provide pair symbol of data.");

    String url = Uri.https(BASE_URL, POINT_API + END_POINT_OPEN_ORDER_ALL, {"sym": "$currency", "lmt": "$limit"}).toString();
    var response = await http.get(url);
    var responseJson = decodeJsonUtf8(response);

    BitkubMarketOpenOrderAllDao openOrder = BitkubMarketOpenOrderAllDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(openOrder.toJson());
    }

    return openOrder;
  }

  /// This is a [private] api.
  /// Get user's balance in wallet.
  Future<BitkubWalletBalanceDao> fetchWalletBalance({bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_WALLET_BALANCE).toString();

    Map payload = {};
    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyGeneral, payload);
    String jsonPayload = jsonEncode(payload);

    print(jsonPayload);

    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyGeneral), body: jsonPayload);
    var responseJson = decodeJsonUtf8(response);

    BitkubWalletBalanceDao balance = BitkubWalletBalanceDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(balance.toJson());
    }

    return balance;
  }

  /// This is a [private] api.
  /// List all open orders of the given symbol.
  /// Example parameter : currency = "THB_ETH"
  Future<BitkubUserOpenOrderDao> fetchUserOpenOrders({@required String currency, bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_OPEN_ORDER).toString();

    Map payload = {"sym": currency};
    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyGeneral, payload);
    String jsonPayload = jsonEncode(payload);

    print(jsonPayload);

    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyGeneral), body: jsonPayload);
    var responseJson = decodeJsonUtf8(response);

    BitkubUserOpenOrderDao orders = BitkubUserOpenOrderDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(orders.toJson());
    }

    return orders;
  }

  /// This is a [private] api.
  /// List all orders that have already matched.
  /// Example parameter : currency = "THB_ETH"
  Future<BitkubUserOrderHistoryDao> fetchUserOrderHistory({@required String currency, int page = 1, int limit = 100, bool printJson = false}) async {
    String url = Uri.https(BASE_URL, POINT_API + END_POINT_ORDER_HISTORY).toString();

    Map payload = {"sym": currency, "p": page, "limit": limit};
    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyGeneral, payload);
    String jsonPayload = jsonEncode(payload);

    print(jsonPayload);

    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyGeneral), body: jsonPayload);
    var responseJson = decodeJsonUtf8(response);
    print(responseJson);
    BitkubUserOrderHistoryDao history = BitkubUserOrderHistoryDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(history.toJson());
    }

    return history;
  }

  /// This is a [private] api.
  /// List all orders that have already matched.
//  Future<BitkubOrderInformationDao> fetchOrderInformation({@required String currency, @required int orderId, BitkubOpenOrderSide side = BitkubOpenOrderSide.BUY, bool printJson = false}) async {
//    String url = Uri.https(BASE_URL, POINT_API + END_POINT_ORDER_INFORMATION).toString();
//
//    Map payload = {"sym": currency, "id": "$orderId", "sd":  fromBitkubOpenOrderSideToString(side).toLowerCase()};
//
//    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyGeneral, payload);
//    String jsonPayload = jsonEncode(payload);
//
//    print(url);
//    print(jsonPayload);
//
//    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyGeneral), body: jsonPayload);
//    var responseJson = decodeJsonUtf8(response);
//
//    print(responseJson);
//    BitkubOrderInformationDao history = BitkubOrderInformationDao.fromJson(responseJson);
//
//    if (printJson) {
//      print(url);
//      printPrettyJson(history.toJson());
//    }
//
//    return history;
//  }

  /// This is a [private] api.
  /// Create a buy/sell order.
  Future<BitkubCreateOrderResultDao> createOrder({@required String currency, @required double amount, @required double rate, @required BitkubOpenOrderSide side, bool printJson = false}) async {
    String endpoint = "";
    if (side == BitkubOpenOrderSide.BUY) {
      endpoint = END_POINT_CREATE_BUY_ORDER;
    } else {
      endpoint = END_POINT_CREATE_SELL_ORDER;
    }

    String url = Uri.https(BASE_URL, POINT_API + endpoint).toString();

    Map payload = {"sym": currency, "amt": "$amount", "rat": "$rate", "typ": "limit"};

    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyCreateOrder, payload);
    String jsonPayload = jsonEncode(payload);

    print(url);
    print(jsonPayload);

    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyCreateOrder), body: jsonPayload);
    var responseJson = decodeJsonUtf8(response);

    print(responseJson);
    BitkubCreateOrderResultDao result = BitkubCreateOrderResultDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(result.toJson());
    }

    return result;
  }

  /// This is a [private] api.
  /// Cancel order.
  Future<BitkubCancelOrderResultDao> cancelOrder({@required String currency, @required int orderId, @required BitkubOpenOrderSide side, bool printJson = false}) async {

    String url = Uri.https(BASE_URL, POINT_API + END_POINT_CANCEL_ORDER).toString();

    Map payload = {"sym": currency, "id": "$orderId", "sd": "${fromBitkubOpenOrderSideToString(side)}"};

    payload = BitkubAuthUtils.generateSignatureAndIncludeToPayload(apiKeyCancelOrder, payload);
    String jsonPayload = jsonEncode(payload);

    print(url);
    print(jsonPayload);

    var response = await http.post(url, headers: BitkubAuthUtils.createHeader(apiKeyCancelOrder), body: jsonPayload);
    var responseJson = decodeJsonUtf8(response);

    print(responseJson);
    BitkubCancelOrderResultDao result = BitkubCancelOrderResultDao.fromJson(responseJson);

    if (printJson) {
      print(url);
      printPrettyJson(result.toJson());
    }

    return result;
  }
}
