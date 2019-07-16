enum BitkubOpenOrderType { BIDS, ASKS }

String fromBitkubOpenOrderTypeToString(BitkubOpenOrderType type){
 return type == BitkubOpenOrderType.BIDS ? "BIDS" : "ASKS";
}