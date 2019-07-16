import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void printPrettyJson(Map map) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(map);
  debugPrint(pretty);
}

Map decodeJsonUtf8(Response response){
  return json.decode(utf8.decode(response.bodyBytes));
}