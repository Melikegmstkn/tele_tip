import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/model/user_model.dart';
import 'package:tele_tip/my_widget/error_dialog.dart';
import 'package:tele_tip/service/doctor.dart';
import 'package:tele_tip/service/user.dart';
import 'package:tele_tip/view/home/home_page.dart';

enum LoginState { busy, idle }

class LoginViewModel with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  set currentUser(User? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

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

  loginUser({required String email, required String password}) async {
    debugPrint("USER GİRİŞ YAPILIYOR -> ");
    var result = await getUserLogin(
      "login-user",
      email.toString(),
    );
    debugPrint("USER GİRİŞ  -> ");
    // debugPrint("USER   -> " + result.first.name!);
    if (password == result!.password) {
      currentUser = result;
      debugPrint("USER GİRİŞ TAMAM -> ");
      return true;
    } else {
      debugPrint("USER GİRİŞ OLMADI -> ");
      return false;
    }
  }

  loginDoctor({required String email, required String password}) async {
    debugPrint("DOKTOR PASS bekle -> ");
    var result = await doctorLogin(
      "login-doctor",
      {"email": email},
    );
    debugPrint("DOKTOR PASS -> " + result);
    if (password == result["password"].toString()) {
      return true;
    } else {
      return const ErrorAlertDialog(
        message: "Email veya şifre hatalı",
      );
    }
  }

  createUser(
      BuildContext context, String name, String email, String password) async {
    var result = await registerUser(
      "create-user",
      {"name": name, "email": email, "password": password},
    );
    if (result.ok) {
      debugPrint("KAYIT BAŞARILI");
      Navigator.push(
          context,
          (MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const HomePage(),
            ),
          )));
    }
  }
}
