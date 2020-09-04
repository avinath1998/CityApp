import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeTab extends StatefulWidget {
  final ScrollController scrollController;

  const MeTab({Key key, this.scrollController}) : super(key: key);
  @override
  _MeTabState createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30.0))),
        margin: const EdgeInsets.only(top: 70.0),
        child: CustomScrollView(
          controller: widget.scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.maybePop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text("Under development",
                          style: Theme.of(context).textTheme.subhead),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
