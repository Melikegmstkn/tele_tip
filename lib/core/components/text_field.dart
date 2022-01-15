import 'package:flutter/material.dart';
import 'package:tele_tip/core/extension/context_extensions.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  final String? text;
  final bool? isObscure;
  const MyTextField(this.controller,
      {Key? key,
      this.hintText,
      this.labelText,
      this.icon,
      this.isObscure = false,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.paddingMediumHorizontal,
      padding: context.paddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Text(text!)),
          Expanded(
            flex: 4,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: context.paddingLow,
                prefixIcon: Icon(icon, color: const Color(0xFF072A8D)),
                hintText: hintText,
                labelText: labelText,
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
              obscureText: isObscure!,
            ),
          ),
        ],
      ),
    );
  }
}
