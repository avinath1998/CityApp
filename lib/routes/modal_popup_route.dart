import 'package:citycollection/screens/me/home_tab.dart';
import 'package:flutter/material.dart';

class ModalPopupRoute extends PopupRoute<ModalPopupRoute> {
  @override
  Color get barrierColor => Colors.white10;

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  String get barrierLabel => "TestBarier";

  @override
  Widget buildPage(BuildContext context, animation, secondaryAnimation) {
    Offset begin = Offset(0.0, 1.0);
    Offset end = Offset(0.0, 0.0);
    var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeIn));
    var offsetAnimation = animation.drive(tween);
    return Container(
      height: 20.0,
      child: SlideTransition(
        child: ClipRRect(
          child: HomeTab(),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        position: offsetAnimation,
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}
