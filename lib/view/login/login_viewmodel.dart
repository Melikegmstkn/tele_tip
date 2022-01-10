import 'package:flutter/material.dart';

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
}
