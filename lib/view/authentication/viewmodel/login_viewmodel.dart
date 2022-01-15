import 'package:flutter/material.dart';
import 'package:tele_tip/service/user.dart';
import 'package:tele_tip/view/home/home_page.dart';

enum LoginState { busy, idle }

class LoginViewModel with ChangeNotifier {
  LoginState _state = LoginState.idle;
  LoginState get state => _state;
  set state(LoginState state) {
    _state = state;
    notifyListeners();
  }

  bool? _isLogin = true;
  bool? get isLogin => _isLogin;
  set isLogin(bool? isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  bool _isObscure = true;
  bool get isObscure => _isObscure;
  set isObscure(bool obscurePassword) {
    _isObscure = obscurePassword;
    notifyListeners();
  }

  String? valid(value) {
    if (value!.length == 0) {
      return "boş bırakılamaz";
    } else if (value!.length < 6) {
      return "6 dan fazla olmalı";
    }
  }

  getCurrentUser() async {
    var result = await getUser("users", {});
  }

  createUser(
      BuildContext context, String name, String email, String password) async {
    var result = await registerUser("create-user", {
      "name": name,
      "email": email,
      "password": password,
    });
    if (result.ok) {
      print("KAYIT BAŞARILI");
      Navigator.push(
          context, (MaterialPageRoute(builder: (context) => const HomePage())));
    }
  }
}
