import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/my_widget/custom_textfield.dart';
import 'package:tele_tip/my_widget/error_dialog.dart';
import 'package:tele_tip/view/authentication/viewmodel/login_viewmodel.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = Provider.of<LoginViewModel>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: _screenWidth * 0.15,
              backgroundColor: Colors.white,
              backgroundImage:
                  _imageFile == null ? null : FileImage(_imageFile!),
              child: _imageFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: _screenWidth * 0.15,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  data: Icons.person,
                  hintText: "Ad",
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _emailController,
                  data: Icons.person,
                  hintText: "e-mail",
                  isObsecure: false,
                ),
                CustomTextField(
                  controller: _passwordController,
                  data: Icons.person,
                  hintText: "Sifre",
                  isObsecure: true,
                ),
                CustomTextField(
                  controller: _repasswordController,
                  data: Icons.person,
                  hintText: "Sifreyi tekrar giriniz",
                  isObsecure: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _loginViewModel.createUser(
                context,
                _nameController.text,
                _emailController.text,
                _passwordController.text),
            child: const Text(
              "Kayıt ol",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            height: 4.0,
            width: _screenWidth * 0.8,
            color: Colors.black54,
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorAlertDialog(
              message: "Lütfen fotograf seciniz!",
            );
          });
    } else {}
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }
}
