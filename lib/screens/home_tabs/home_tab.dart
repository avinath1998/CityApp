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

import 'me_tab.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;

  const HomeTab({Key key, this.scrollController}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> testList = ["123", "23", "23", "431", "213"];
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color: CityColors.primary_teal,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Hi ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontWeight: FontWeight.bold)),
                          // TextSpan(
                          //     text: BlocProvider.of<AuthBloc>(
                          //           context,
                          //         ).currentUser.name.split(" ")[0] +
                          //         ",",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .headline4
                          //         .copyWith(fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      Text(
                        "here are your bins.",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("taggedBins")
                    .where("userId",
                        isEqualTo:
                            BlocProvider.of<AuthBloc>(context).currentUser.id)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Text("An error has occured, try again.")),
                      );
                      break;
                    case ConnectionState.waiting:
                      return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                      break;
                    case ConnectionState.active:
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          Map<String, dynamic> innerMap =
                              snapshot.data.documents[index].data;
                          innerMap["id"] =
                              snapshot.data.documents[index].documentID;
                          TaggedBin bin = TaggedBin.fromJson(innerMap);
                          return Container(
                            margin: const EdgeInsets.all(5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text(bin.binName)),
                              ),
                            ),
                          );
                        }, childCount: snapshot.data.documents.length),
                      );

                      break;
                    case ConnectionState.done:
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Text("An error has occured, try again.")),
                      );
                      break;
                    default:
                      return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
