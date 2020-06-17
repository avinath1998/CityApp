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
  List<String> testList = ["123", "23", "23", "431", "213"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Hi ",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: BlocProvider.of<AuthBloc>(context)
                                  .currentUser
                                  .name
                                  .split(" ")[0] +
                              ",",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  Text(
                    "have you recycled today?",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Test")),
                  ),
                ),
              );
            }, childCount: testList.length),
          )
        ],
      ),
    );
  }
}
