import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/view/login/login_page.dart';
import 'package:tele_tip/view/login/login_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TELE TIP",
        home: LoginPage(),
      ),
    );
  }
}
