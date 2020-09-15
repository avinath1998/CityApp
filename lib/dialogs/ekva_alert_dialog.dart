import 'package:citycollection/screens/home_screen.dart';
import 'package:flutter/material.dart';

class EkvaAlertDialog extends StatefulWidget {
  final String message;
  final Function() onOkPressed;

  const EkvaAlertDialog({Key key, this.message, this.onOkPressed})
      : super(key: key);
  @override
  _EkvaAlertDialogState createState() => _EkvaAlertDialogState();
}

class _EkvaAlertDialogState extends State<EkvaAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(widget.message)],
      ),
      actions: [
        RaisedButton(
          color: Theme.of(context).buttonColor,
          shape: Theme.of(context).buttonTheme.shape,
          child: Text("Ok"),
          onPressed: () {
            widget.onOkPressed();
          },
        )
      ],
    );
  }
}
