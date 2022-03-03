import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/my_widget/error_dialog.dart';
import 'package:tele_tip/view/authentication/view/doctor_login.dart';
import 'package:tele_tip/view/authentication/viewmodel/login_viewmodel.dart';
import 'package:tele_tip/view/home/home_page.dart';
import 'package:tele_tip/view/home/home_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = Provider.of<LoginViewModel>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            child: Image.asset("assets/images/hospital.jpg"),
            height: 240.0,
            width: 240.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Giris yapınız",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Form(
            key: _formKey,
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
          ElevatedButton(
            onPressed: () {
              _emailController.text.isNotEmpty
                  ? _passwordController.text.isNotEmpty
                      ? _loginViewModel
                          .loginUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                          .then((value) => {
                                if (value)
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                  create: (_) => HomeViewModel(
                                                      user: _loginViewModel
                                                          .currentUser!),
                                                  child: const HomePage(),
                                                )))
                                  }
                                else
                                  {
                                    const ErrorAlertDialog(
                                      message: "Email veya şifre hatalı",
                                    )
                                  }
                              })
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return const ErrorAlertDialog(
                              message: "Şifrenizi giriniz...!",
                            );
                          })
                  : showDialog(
                      context: context,
                      builder: (c) {
                        return const ErrorAlertDialog(
                          message: "Email boş bırakılamaz...!",
                        );
                      });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text(
              "Giris",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Container(
            height: 4.0,
            width: _screenWidth * 0.8,
            color: Colors.black54,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (_) => LoginViewModel(),
                          child: const DoctorLoginPage(),
                        ))),
            child: Row(
              children: const [
                Expanded(
                  child: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Doktor girisi",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
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
