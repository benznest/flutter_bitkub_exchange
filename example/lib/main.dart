import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bitkub_exchange/bitkub_exchange.dart';
import 'package:flutter_bitkub_exchange/bitkub_open_order_type.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';

Future main() async {
  BitkubExchangeService bk = BitkubExchangeService(
      apiKeyGeneral: BitkubApiKey(apiKey: "-", secret: "-"), apiKeyCreateOrder: BitkubApiKey(apiKey: "-", secret: "-"), apiKeyCancelOrder: BitkubApiKey(apiKey: "-", secret: "-"));

  await bk.fetchMarketTicker();
//  var server = await bk.fetchServerTime(printJson: true);
//  var data = await bk.fetchMarketSymbols();
// var recent = await bk.fetchRecentTrades(currency: "THB_BTC", limit: 100);
//  await bk.fetchRecentTrades(currency: "xx", limit: 10, printJson: true); // Error case

  var openOrder = await bk.fetchMarketOpenOrders(orderType: BitkubOpenOrderType.BIDS, currency: "THB_BTC", limit: 10, printJson: true);
  if (openOrder.isError()) {
    // openOrder.errorMessage
  } else {
    for (var order in openOrder.orders) {
      // order.orderId;
      // order.amount;
      // order.rate;
      // order.volume;
      // order.timestam;
    }
  }

//  await bk.fetchOpenOrder(currency: "xx", limit: 10, printJson: true); // Error case
//  await bk.fetchOpenOrder(orderType: BitkubOpenOrderType.ASKS, currency: "THB_BTC", limit: 10, printJson: true);

  var market = await bk.fetchMarketOpenOrdersAll(currency: "THB_BTC", limit: 10);
  if (market.isError()) {
    // openOrder.errorMessage
  } else {
    // market.bids;
    // market.asks;
  }

//  await bk.fetchOpenOrderAll(currency: "ZZ", limit: 10, printJson: true);// Error case

//  await bk.fetchWalletBalance(printJson: true);
//  await bk.fetchOpenOrders(currency: "THB_ETH", printJson: true);
//  await bk.fetchOrderHistory(currency: "THB_ETH",printJson: true);
//  await bk.createOrder(currency: "THB_ETH",side: BitkubOpenOrderSide.BUY,amount: 30,rate: 100,printJson: true);

//  await bk.cancelOrder(currency: "THB_ETH",side: BitkubOpenOrderSide.BUY,orderId: 3132207,printJson: true);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bitkub'),
        ),
        body: Center(
          child: Text('BITKUB.COM'),
        ),
      ),
    );
  }
}
