import 'package:flutter/material.dart';

class ButtonErrorRefresh extends StatefulWidget {
  final String errorMsg;
  final Function() onRefreshTapped;

  const ButtonErrorRefresh({Key key, this.errorMsg, this.onRefreshTapped})
      : super(key: key);
  @override
  _ButtonErrorRefreshState createState() => _ButtonErrorRefreshState();
}

class _ButtonErrorRefreshState extends State<ButtonErrorRefresh> {
  @override
  Widget build(BuildContext context) {
    assert(widget.errorMsg != null);
    assert(widget.onRefreshTapped != null);
    return Center(
        child: Column(
      children: [
        Text(widget.errorMsg),
        GestureDetector(
          child: Icon(Icons.refresh),
        )
      ],
    ));
  }
}
