import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static info(BuildContext context, { String? title, String? content}) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class ProgressDialog {
  final BuildContext context;
  ProgressDialog(this.context);

  void show() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }
}
