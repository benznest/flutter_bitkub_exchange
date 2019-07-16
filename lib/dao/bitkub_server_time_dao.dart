class BitKubServerTimeDao{
  int serverTime;

  BitKubServerTimeDao({this.serverTime=0});

  Map<String, dynamic> toJson() {
    return {"serverTime": this.serverTime,};
  }
}