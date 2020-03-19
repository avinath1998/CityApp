import 'package:flutter/material.dart';

class LargeLoadingScreen extends StatefulWidget {
  @override
  _LargeLoadingScreenState createState() => _LargeLoadingScreenState();
}

class _LargeLoadingScreenState extends State<LargeLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
