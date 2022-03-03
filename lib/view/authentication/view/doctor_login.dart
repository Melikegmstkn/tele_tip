import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/model/user_model.dart';
import 'package:tele_tip/my_widget/custom_textfield.dart';
import 'package:tele_tip/my_widget/error_dialog.dart';
import 'package:tele_tip/view/authentication/view/authenication.dart';
import 'package:tele_tip/view/authentication/viewmodel/login_viewmodel.dart';
import 'package:tele_tip/view/home/home_page.dart';
import 'package:tele_tip/view/home/home_viewmodel.dart';

class DoctorLoginPage extends StatelessWidget {
  const DoctorLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.blueGrey[100]!],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: const Text(
            "TELE-TIP",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
          child: const DoctorLoginScreen(),
        ));
  }
}

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({Key? key}) : super(key: key);

  @override
  _DoctorLoginScreenState createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _doctorMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.blueGrey[100]!],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
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
                "Doktor",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _doctorMailController,
                    data: Icons.person,
                    hintText: "Doktor mail",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    data: Icons.person,
                    hintText: "Sifre",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                _doctorMailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? loginViewModel
                        .loginDoctor(
                            email: _doctorMailController.text,
                            password: _passwordController.text)
                        .then((value) => {
                              if (value)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    HomeViewModel(user: User()),
                                                child: const HomePage(
                                                  isItDoctor: true,
                                                )),
                                      ))
                                }
                              else
                                {
                                  const ErrorAlertDialog(
                                    message: "Hatalı mail",
                                  )
                                }
                            })
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return const ErrorAlertDialog(
                            message: "verileri giriniz",
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
            const SizedBox(height: 50.0),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.black54,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthenticScreen())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded(
                    child: Text("Kullanıcı Girisi",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.people,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
