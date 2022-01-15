import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/view/authentication/view/register.dart';
import 'package:tele_tip/view/authentication/viewmodel/login_viewmodel.dart';
import 'login.dart';

class AuthenticScreen extends StatefulWidget {
  const AuthenticScreen({Key? key}) : super(key: key);

  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            "TELE-TİP",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.black),
                text: "GİRİS YAP",
              ),
              Tab(
                icon: Icon(Icons.lock, color: Colors.black),
                text: "KAYIT OL",
              )
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.blueGrey[100]!],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: TabBarView(
            children: [
              ChangeNotifierProvider(
                create: (_) => LoginViewModel(),
                child: const LoginPage(),
              ),
              ChangeNotifierProvider(
                create: (_) => LoginViewModel(),
                child: const Register(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
