import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../redemptions_screen.dart';
import '../see_tagged_bins_screen.dart';
import 'me_tab.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;

  const HomeTab({Key key, this.scrollController}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color: CityColors.primary_teal,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Hi ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: BlocProvider.of<AuthBloc>(
                                      context,
                                    ).currentUser.name.split(" ")[0] +
                                    ",",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Heres your information.",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          RaisedButton(
                            child: Text("See Trash Disposals"),
                            onPressed: () {},
                          ),
                          FlatButton(
                            child: Text("See Tagged Bins"),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SeeTaggedBinsScreen.routeName);
                            },
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RedemptionsScreen.routeName);
                            },
                            child: Text(
                              "See Your Redemptions",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
