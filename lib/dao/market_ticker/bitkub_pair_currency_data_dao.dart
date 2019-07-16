class BitkubPairCurrencyDataDao {
  String pairName;
  int id;
  double last;
  double lowestAsk;
  double highestBid;
  double percentChange;
  double baseVolume;
  double quoteVolume;
  int isFrozen;
  double high24hr;
  double low24hr;

  BitkubPairCurrencyDataDao(
      {this.pairName,
      this.id,
      this.last,
      this.lowestAsk,
      this.highestBid,
      this.percentChange,
      this.baseVolume,
      this.quoteVolume,
      this.isFrozen,
      this.high24hr,
      this.low24hr});

  BitkubPairCurrencyDataDao.fromJson(this.pairName ,Map<String, dynamic> json) {
    id = json['id'];
    last = double.parse(json['last'].toString());
    lowestAsk = double.parse(json['lowestAsk'].toString());
    highestBid = double.parse(json['highestBid'].toString());
    percentChange = double.parse(json['percentChange'].toString());
    baseVolume = double.parse(json['baseVolume'].toString());
    quoteVolume = double.parse(json['quoteVolume'].toString());
    isFrozen = json['isFrozen'];
    high24hr = double.parse(json['high24hr'].toString());
    low24hr = double.parse(json['low24hr'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pairName'] = this.pairName;
    data['id'] = this.id;
    data['last'] = this.last;
    data['lowestAsk'] = this.lowestAsk;
    data['highestBid'] = this.highestBid;
    data['percentChange'] = this.percentChange;
    data['baseVolume'] = this.baseVolume;
    data['quoteVolume'] = this.quoteVolume;
    data['isFrozen'] = this.isFrozen;
    data['high24hr'] = this.high24hr;
    data['low24hr'] = this.low24hr;
    return data;
  }
}
