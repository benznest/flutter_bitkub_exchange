class BitkubMarketSymbolItemDao {
  int id;
  String info;
  String symbol;

  BitkubMarketSymbolItemDao({this.id, this.info, this.symbol});

  factory BitkubMarketSymbolItemDao.fromJson(Map<String, dynamic> json) {
    return BitkubMarketSymbolItemDao(
      id: json["id"],
      info: json["info"],
      symbol: json["symbol"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id, "info": this.info, "symbol": this.symbol};
  }
}
