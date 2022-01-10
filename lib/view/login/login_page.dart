import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/core/components/platform_alert_dialog.dart';
import 'package:tele_tip/view/home/home_page.dart';

import 'login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _telNumberController = TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();

  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.blueGrey.shade100,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.healing_rounded,
              size: 50.0,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blueGrey.shade100,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              _loginViewModel.isLogin!
                  ? const SizedBox(
                      height: 100,
                      width: 70,
                      child: Icon(Icons.star),
                    )
                  : Container(),
              _loginViewModel.isLogin!
                  ? buildLoginForm(context, _loginViewModel)
                  : buildRegisterForm(context, _loginViewModel),
              const SizedBox(height: 30.0),
              buildLoginAndRegisterButton(_loginViewModel, context),
              TextButton(
                  onPressed: () {
                    _loginViewModel.isLogin = !_loginViewModel.isLogin!;
                    _loginViewModel.isObscure = true;
                    _nameSurnameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    _rePasswordController.clear();
                    _telNumberController.clear();
                  },
                  child: _loginViewModel.isLogin!
                      ? const Text("Hesabın yok mu? kayıt ol")
                      : const Text("Zaten hesabın var mı? Giriş Yap"))
            ],
          ),
        ),
      ),
    );
  }

  Form buildLoginForm(BuildContext context, LoginViewModel _loginViewModel) {
    return Form(
      key: formKeyLogin,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTextFormField(
              _emailController,
              "email",
              Icons.email,
              validator: (value) => _loginViewModel.valid(value),
            ),
            buildTextFormField(
              _passwordController,
              "şifre",
              Icons.vpn_key,
              loginViewModel: _loginViewModel,
              validator: (value) => _loginViewModel.valid(value),
            ),
          ],
        ),
      ),
    );
  }

  Form buildRegisterForm(BuildContext context, LoginViewModel _loginViewModel) {
    return Form(
      key: formKeyRegister,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTextFormField(
              _nameSurnameController,
              "ad soyad",
              Icons.person,
              validator: (value) => _loginViewModel.valid(value),
            ),
            buildTextFormField(
              _emailController,
              "e-mail",
              Icons.email,
              validator: (value) => _loginViewModel.valid(value),
            ),
            buildTextFormField(
              _passwordController,
              "şifre",
              Icons.vpn_key,
              loginViewModel: _loginViewModel,
              validator: (value) => _loginViewModel.valid(value),
            ),
            buildTextFormField(
              _rePasswordController,
              "şifreyi tekrar giriniz",
              Icons.vpn_key,
              loginViewModel: _loginViewModel,
              validator: (value) => _loginViewModel.valid(value),
            ),
            buildTextFormField(_telNumberController, "telefon", Icons.call),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildLoginAndRegisterButton(
      LoginViewModel _loginViewModel, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_loginViewModel.isLogin!) {
          if (formKeyLogin.currentState!.validate()) {
            formKeyLogin.currentState!.save();
            if (_loginViewModel.state == LoginState.idle) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Center(child: Text("giriş yapılıyor")),
                    content: LinearProgressIndicator(),
                  );
                },
              );
            }
          }
        } else {
          if (formKeyRegister.currentState!.validate()) {
            if (_passwordController.text != _rePasswordController.text) {
              PlatformAlertDialog(
                title: "Uyarı",
                contentText: "Şifreler Eşleşmiyor",
                basicButtonText: "Tamam",
                onPressedBasicButton: () {
                  Navigator.pop(context);
                },
              );
            } else {
              formKeyRegister.currentState!.save();
              if (_loginViewModel.state == LoginState.idle) {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const HomePage()));
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Center(child: Text("hata")),
                      content: LinearProgressIndicator(),
                    );
                  },
                );
              }
            }
          }
        }
      },
      child: _loginViewModel.isLogin!
          ? const Text("giriş")
          : const Text("kayıt ol"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF072A8D)),
        minimumSize: MaterialStateProperty.all(const Size.fromRadius(20.0)),
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(350.0)),
      ),
    );
  }

  Widget buildTextFormField(
      TextEditingController controller, String hintText, IconData icon,
      {LoginViewModel? loginViewModel, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          prefixIcon: Icon(icon, color: const Color(0xFF072A8D)),
          suffixIcon: loginViewModel != null
              ? IconButton(
                  onPressed: () {
                    loginViewModel.isObscure = !loginViewModel.isObscure;
                  },
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                )
              : null,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.white),
            gapPadding: 5.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.white),
            gapPadding: 5.0,
          ),
        ),
        obscureText: loginViewModel != null ? loginViewModel.isObscure : false,
        validator: validator,
      ),
    );
  }
}
