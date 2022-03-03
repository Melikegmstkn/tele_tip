import 'package:flutter/material.dart';
import 'package:tele_tip/model/user_model.dart';
import 'package:tele_tip/service/user.dart';

class HomeViewModel with ChangeNotifier {
  final User user;
  HomeViewModel({required this.user}) {
    getUsersList();
  }

  List<User> _userList = [];
  List<User> get userList => _userList;
  set userList(List<User> userList) {
    _userList = userList;
    notifyListeners();
  }

  getUsersList() async {
    var result = await getUserList(route: "users");
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        userList.add(result[i]);
        debugPrint("USER $i -> " + result[i].name!);
      }
      debugPrint("Liste BAŞARILI");
    }
  }
}
