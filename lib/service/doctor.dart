import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:tele_tip/model/doctor_model.dart';
import 'package:tele_tip/service/user.dart';

Future<List<Doctor>> getDoctorsList({required String route}) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";
  var result = await http.get(Uri.parse(url));

  var data = jsonDecode(result.body);

  debugPrint("DATA -> " + data.toString());

  return (data as List).map((p) => Doctor.fromJson(p)).toList();
}

Future doctorLogin(String route, dynamic data) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(Uri.parse(url),
      body: dataStr, headers: {"Content-Type": "application/json"});
  return jsonDecode(result.body);
}
