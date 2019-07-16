class BitkubApiKey {
  String apiKey;
  String secret;

  BitkubApiKey({this.apiKey = "", this.secret = ""}){
    apiKey = apiKey.trim();
    secret = secret.trim();
  }
}