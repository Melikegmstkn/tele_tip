import 'package:flutter/material.dart';

class PlatformAlertDialog {
  final String title;
  final String contentText;
  final String? cancelButtonText;
  final String? basicButtonText;
  final VoidCallback? onPressedBasicButton;
  final VoidCallback? onPressedButton;

  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.contentText,
    this.basicButtonText,
    this.cancelButtonText,
    this.onPressedButton,
    this.onPressedBasicButton,
  });

  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: _contentWidget(contentText, context),
      actions: _dialogButtonsActions(context),
    );
  }

  List<Widget> _dialogButtonsActions(BuildContext context) {
    final List<Widget> allButtons = <Widget>[];

    allButtons.add(
      TextButton(
        onPressed: onPressedBasicButton,
        child: Text(basicButtonText ?? ""),
      ),
    );
    if (cancelButtonText != null) {
      allButtons.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(cancelButtonText!),
        ),
      );
    }
    return allButtons;
  }

  Text _contentWidget(String content, BuildContext context) {
    return Text(content);
  }
}
