import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Welcome",
                          style: Theme.of(context).textTheme.display1),
                      TextSpan(
                          text: BlocProvider.of<AuthBloc>(context)
                                  .currentUser
                                  .name +
                              ",",
                          style: Theme.of(context).textTheme.display2),
                      TextSpan(
                          text: "\nWhat do you want to do today?\n",
                          style: Theme.of(context).textTheme.subhead),
                    ]),
                  ))
            ],
          ),
        ));
  }
}
