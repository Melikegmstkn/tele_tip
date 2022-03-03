import 'package:flutter/cupertino.dart';
import 'package:tele_tip/model/doctor_model.dart';
import 'package:tele_tip/model/profession_model.dart';
import 'package:tele_tip/model/search_model.dart';
import 'package:tele_tip/service/doctor.dart';
import 'package:tele_tip/service/proffession_service.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel() {
    getDoctorList();
  }

  List<Doctor> _doctorList = [];
  List<Doctor> get doctorList => _doctorList;
  set doctorList(List<Doctor> doctorList) {
    _doctorList = doctorList;
    notifyListeners();
  }

  List<ProfessionSearch> professionSearchList = [];

  Future<List<Doctor>> getDoctorList() async {
    var result = await getDoctorsList(route: "doctors");
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        doctorList.add(result[i]);
        debugPrint("DOCTOR $i -> " + result[i].name!);
      }
      debugPrint("Liste BAŞARILI");
    }
    return doctorList;
  }

  Future<List<ProfessionSearch>> getProfessionDoctorList(
      {required String searchProfessionName}) async {
    var result = await getProfessionSearch(
        route: "search/profession", searchProfessionName: searchProfessionName);

    if (result!.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        professionSearchList.add(result[i]);
        debugPrint("PROFESSİON $i -> " + result[i].professionName!);
      }
      debugPrint("Liste BAŞARILI");
    }
    return professionSearchList;
  }
}
