import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:tele_tip/model/profession_model.dart';
import 'package:tele_tip/model/search_model.dart';
import 'package:tele_tip/service/user.dart';

Future<List<Profession>> getProfessionList({required String route}) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";

  var result = await http.get(Uri.parse(url));

  var data = jsonDecode(result.body);

  debugPrint("DATA -> " + data.toString());
  return (data as List).map((p) => Profession.fromJson(p)).toList();
}

Future<List<ProfessionSearch>> getProfessionSearchh(
    {required String route, required String searchProfessionName}) async {
  var url = "${Domain.protokol}://${Domain.domain}/$route";

  var result = await http.get(Uri.parse(url));

  var data = jsonDecode(result.body);

  debugPrint("DATA -> " + data.toString());
  return (data as List).map((p) => ProfessionSearch.fromJson(p)).toList();
}

Future<List<ProfessionSearch>?> getProfessionSearch(
    {required String route, required String searchProfessionName}) async {
  try {
    var url = "${Domain.protokol}://${Domain.domain}/$route";
    var dataStr = jsonEncode({"professionName": searchProfessionName});

    var result = await http.post(Uri.parse(url),
        body: dataStr, headers: {"Content-Type": "application/json"});

    var data = jsonDecode(result.body);
    debugPrint("PROFESSİON DOCTOR -> " + data.toString());
    return (data as List).map((p) => ProfessionSearch.fromJson(p)).toList();
  } catch (e) {
    debugPrint("Profession search error $e");
  }
}
