# Flutter Bitkub Exchange 

Flutter Bitkub Exchange is a Flutter's library for calling API of the [https://www.bitkub.com/](https://www.bitkub.com/)

## Installation
Add dependencies in pubspec.yaml

```bash
flutter_bitkub_exchange: 1.0.0
```

## Usage

Import the package to your project.

```dart
import 'package:flutter_bitkub_exchange/bitkub_exchange.dart';
```

## Using Public API

Create instance without API Key. 

```dart
var bk = BitkubExchangeService();
```


### Market Data (Ticker)

Get ticker information such as last price, high in 24Hr , volume. 
In the case that the wrong currency is returned to a empty list

```dart
  var ticker = await bk.fetchMarketTicker(currency: "THB_BTC");
  for(var currency in ticker.list){
    // currency.id;
    // currency.pairName;
    // currency.last;
    // currency.lowestAsk;
    // currency.highestBid;
    // currency.percentChange;
    // currency.baseVolume;
    // currency.quoteVolume;
    // currency.high24hr;
    // currency.lowestAsk;
  }
```

### Get Server Timestamp

Get server timestamp in seconds (Epoch Unix).

```dart
  var server = await bk.fetchServerTime();
  // server.serverTime;
  }
```


### Get Available Pair-Currency 

Get List all available symbols.

```dart
  var data = await bk.fetchMarketSymbols();
  for(var currency in data.items){
    // currency.id;
    // currency.symbol;
    // currency.info
  }
```


### Get Recent Trade

Get list recent trades.
(limit is number of rows)

```dart
 var recent = await bk.fetchRecentTrades(currency: "THB_BTC", limit: 100);
if(recent.isError()){
  // recent.errorMessage;
}else{
     for(var trade in recent.items){
       // trade.type;
       // trade.amount;
       // trade.rate;
       // trade.timestamp;
     }
}
```


### Get Current Open Order on Market

Get list open orders with bid/ask condition.

```dart
  var openOrder = await bk.fetchMarketOpenOrders(orderType: BitkubOpenOrderType.BIDS, currency: "THB_BTC", limit: 10);
  if(openOrder.isError()){
     // openOrder.errorMessage;
  }else{
    for(var order in openOrder.orders){
      // order.orderId;
      // order.amount;
      // order.rate;
      // order.volume;
      // order.timestam;
    }
  }
```

Get all open orders.

```dart
  var market = await bk.fetchMarketOpenOrdersAll(currency: "THB_BTC", limit: 10);
  if (market.isError()) {
    // market.errorMessage;
  } else {
    // market.bids;
    // market.asks;
  }
```


## Prepare Private API

Prepare 3 API keys.

### 1. General API key 

General API key are used for reading general information, such as balance, open orders , deposit address. 


### 2. Crate Order API key

Crate Order API key are used for creating order.


### 3. Cancel Order API key

Cancel Order API key are used for canceling order.


## Using Private API

Create instance with 3 API keys.

```dart
  var bk = BitkubExchangeService(
      apiKeyGeneral:     BitkubApiKey(apiKey: "-", secret: "-"), 
      apiKeyCreateOrder: BitkubApiKey(apiKey: "-", secret: "-"), 
      apiKeyCancelOrder: BitkubApiKey(apiKey: "-", secret: "-"));
```

### Get Balances

Get balances info: this includes both available and reserved balances.

```dart
  var data = await bk.fetchWalletBalance();
  if(data.isError()){
    // data.errorMessage;
  }else{
    for(var wallet in data.wallets){
      // wallet.currency;
      // wallet.balance;

      // wallet.detail.balance;
      // wallet.detail.available;
      // wallet.detail.reserved;
    }
  }
```


### Get Open Orders

List all open orders of the given symbol.

```dart
 var openOrder =  await bk.fetchUserOpenOrders(currency: "THB_ETH");
  if(openOrder.isError()){
    // data.errorMessage;    
  }else{
    for(var order in openOrder.orders){
      // order.id;
      // order.type;
      // order.rate;
      // order.amount;
      // order.side;
      // order.fee;
      // order.credit;
      // order.receive
    }
  }
```


### Get Transaction History

List all open orders of the given symbol.

```dart
  var data = await bk.fetchUserOrderHistory(currency: "THB_ETH");
  if(data.isError()){
    // data.errorMessage;
  }else{
    for(var tx in data.history){
      // tx.txnId;
      // tx.orderId;
      // tx.side;
      // tx.rate;
      // tx.amount;
      // tx.fee;
      // tx.credit;
      // tx.takenByMe;
      // row.balance;
    }
  }
```








