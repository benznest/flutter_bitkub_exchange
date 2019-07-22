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
     // openOrder.errorMessage
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
    // openOrder.errorMessage
  } else {
    // market.bids;
    // market.asks;
  }
```







