import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  static const String messageButton = "Accept";

  const CustomDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? alertAndroid(context) : alertIOS(context);
  }

  Widget alertAndroid(BuildContext context) {
    return AlertDialog(
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      actionsOverflowButtonSpacing: 20,
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(messageButton))
      ],
      content: Text(message),
    );
  }

  Widget alertIOS(BuildContext context) {
    return CupertinoAlertDialog(
      actions: [
        CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text(messageButton)),
      ],
      content: Text(message),
    );
  }
}
