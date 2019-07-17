import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bitkub_exchange/bitkub_utils.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';

class BitkubAuthUtils {
  static Map<String, String> createHeader(BitkubApiKey key) {
    return {
      "Accept": "application/json",
      "Content-type": "application/json",
      "X-BTK-APIKEY": "${key.apiKey}",
    };
  }

  static Map generateSignatureAndIncludeToPayload(BitkubApiKey key, Map payload) {
    String signature = generateSignature(key, payload).toString();
    payload["sig"] = signature;
    return payload;
  }

  static Digest generateSignature(BitkubApiKey key, Map payload) {
    payload["ts"] = getNonce(); // add timestamp to payload.
    String jsonPayload = jsonEncode(payload);

    var bytesApiKey = utf8.encode(key.secret);
    var bytesPayload = utf8.encode(jsonPayload);

    var hmacSha256 =  Hmac(sha256, bytesApiKey); // HMAC-SHA256
    var digest = hmacSha256.convert(bytesPayload);

    return digest;
  }
}
