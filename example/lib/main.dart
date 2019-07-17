import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bitkub_exchange/bitkub_exchange.dart';
import 'package:flutter_bitkub_exchange/bitkub_open_order_type.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';

Future main() async {
  BitkubExchangeService bk = BitkubExchangeService(
      apiKeyGeneral: BitkubApiKey(apiKey: "e50f5241ab1412804f27cb194da11339",secret: "ecf9d5dd5dfa0cfc4957832aced5080d"));
//  await bk.fetchServerTime(printJson: true);
//  await bk.fetchMarketSymbols(printJson: true);
//  await bk.fetchMarketTicker(printJson: true);
//  await bk.fetchMarketTicker(symbol: "THB_BTC", printJson: true);
//  await bk.fetchRecentTrades(symbol: "THB_BTC", limit: 10, printJson: true);
//  await bk.fetchRecentTrades(symbol: "xx", limit: 10, printJson: true); // Error case
//  await bk.fetchOpenOrder(orderType: BitkubOpenOrderType.BIDS, symbol: "THB_BTC", limit: 10, printJson: true);
//  await bk.fetchOpenOrder(symbol: "xx", limit: 10, printJson: true); // Error case
//  await bk.fetchOpenOrder(orderType: BitkubOpenOrderType.ASKS, symbol: "THB_BTC", limit: 10, printJson: true);
//  await bk.fetchOpenOrderAll(symbol: "THB_BTC", limit: 10, printJson: true);
//  await bk.fetchOpenOrderAll(symbol: "XXX", limit: 10, printJson: true);// Error case
  await bk.fetchWalletBalance(printJson: true);// Error case
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
