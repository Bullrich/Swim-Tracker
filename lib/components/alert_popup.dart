import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String title;
  final String content;
  final String yesText;
  final String noText;

  const AlertPopup({this.title, this.content, this.yesText, this.noText});

  AlertDialog buildAndroidDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(yesText)),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(noText),
        ),
      ],
      elevation: 24,
    );
  }

  CupertinoAlertDialog buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(yesText)),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(noText),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? buildCupertinoDialog(context)
        : buildAndroidDialog(context);
  }
}
