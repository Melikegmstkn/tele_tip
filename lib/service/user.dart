import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:tele_tip/model/user_model.dart';

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

class Domain {
  static String protokol = "http";
  static String domain = "10.36.244.10:8000";
}

Future<User?> getUserLogin(String route, String email) async {
  try {
    var url = "${Domain.protokol}://${Domain.domain}/$route";
    var dataStr = jsonEncode({"email": email});

    var result = await http.post(Uri.parse(url),
        body: dataStr, headers: {"Content-Type": "application/json"});

    debugPrint("DATA -> " + jsonDecode(result.body).toString());
    // var s = User.fromJson(jsonDecode(result.body));
    var data = jsonDecode(result.body);
    debugPrint("USER -> " + User.fromJson(data[0]).toString());

    return User.fromJson(data[0]);
  } catch (e) {
    debugPrint("User login error $e");
  }
}

Future<List<User>> getUserList({required String route}) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";
  var result = await http.get(Uri.parse(url));

  var data = jsonDecode(result.body);

  debugPrint("DATA -> " + data.toString());
  return (data as List).map((p) => User.fromJson(p)).toList();
}

Future<RequestResult> registerUser(String route, dynamic data) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(Uri.parse(url),
      body: dataStr, headers: {"Content-Type": "application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
