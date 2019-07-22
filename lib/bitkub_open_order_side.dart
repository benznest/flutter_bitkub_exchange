enum BitkubOpenOrderSide { BUY, SELL }

String fromBitkubOpenOrderSideToString(BitkubOpenOrderSide type) {
  return type == BitkubOpenOrderSide.BUY ? "BUY" : "SELL";
}

BitkubOpenOrderSide fromStringToBitkubOpenOrderSide(String type) {
  type = type.toUpperCase().trim();
  return type == "BUY" ? BitkubOpenOrderSide.BUY : BitkubOpenOrderSide.SELL;
}
