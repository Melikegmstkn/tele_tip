import 'dart:convert';

import "package:http/http.dart" as http;

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const protokol = "http";
const domain = "10.36.242.20:8000";

Future<RequestResult> getUser(String route, dynamic data) async {
  var dataStr = jsonEncode(data);
  var url = "$protokol://$domain/$route?data=$dataStr";
  var result = await http.get(Uri.parse(url));
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> registerUser(String route, dynamic data) async {
  var url = "$protokol://$domain/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(Uri.parse(url),
      body: dataStr, headers: {"Content-Type": "application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
