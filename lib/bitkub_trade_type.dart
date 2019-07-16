enum BitkubTradeType { BUY, SELL }

String fromBitkubTradeTypeToString(BitkubTradeType type) {
  return type == BitkubTradeType.BUY ? "BUY" : "SELL";
}

BitkubTradeType fromStringToBitkubTradeType(String type) {
  return type == "BUY" ? BitkubTradeType.BUY : BitkubTradeType.SELL;
}
