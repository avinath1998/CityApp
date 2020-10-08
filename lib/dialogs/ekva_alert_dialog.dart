import 'package:citycollection/screens/home_screen.dart';
import 'package:flutter/material.dart';

class EkvaAlertDialog extends StatefulWidget {
  final String message;
  final Function() onOkPressed;
  final String title;
  const EkvaAlertDialog({Key key, this.message, this.onOkPressed, this.title})
      : super(key: key);
  @override
  _EkvaAlertDialogState createState() => _EkvaAlertDialogState();
}

class _EkvaAlertDialogState extends State<EkvaAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title ?? "Alert",
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.start,
      ),
      content: Text(
        widget.message,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        RaisedButton(
          child: Text("Ok"),
          onPressed: () {
            widget.onOkPressed();
          },
        )
      ],
    );
  }
}
