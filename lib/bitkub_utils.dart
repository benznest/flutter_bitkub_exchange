import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';

void printPrettyJson(Map map) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(map);
  debugPrint(pretty);
}

Map decodeJsonUtf8(Response response) {
  return json.decode(utf8.decode(response.bodyBytes));
}

int getNonce() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
