import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/screens/me/see_trash_disposals_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citycollection/extensions/date_time_extension.dart';

import 'redemptions_screen.dart';
import 'see_tagged_bins_screen.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;

  const HomeTab({Key key, this.scrollController}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

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
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                children: [
                                  Icon(Icons.expand_less),
                                  Text(
                                    "Swipe up",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                            ),
                          ),
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
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Hi ",
                                style: Theme.of(context).textTheme.headline5),
                            TextSpan(
                                text: BlocProvider.of<AuthBloc>(
                                      context,
                                    ).currentUser.firstName +
                                    ",",
                                style: Theme.of(context).textTheme.headline5),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                child: Text("My Disposals"),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      SeeTrashDisposalsScreen.routeName);
                                },
                              ),
                              FlatButton(
                                child: Text("My Bins"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SeeTaggedBinsScreen.routeName);
                                },
                              ),
                            ],
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RedemptionsScreen.routeName);
                            },
                            child: Text(
                              "My Prizes",
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (oldState, newState) {
                          return newState is SignedInState;
                        },
                        builder: (context, state) {
                          if (state is SignedInState) {
                            return _buildForm(state.user);
                          } else if (state is AuthUpdatedState) {
                            return _buildForm(state.user);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
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

  Widget _buildForm(CurrentUser user) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: user.firstName,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Name",
              icon: Icon(Icons.account_circle),
            ),
            style: Theme.of(context).textTheme.bodyText1,
            validator: (val) {
              if (val == "") {
                return "Enter a valid name.";
              }
            },
            onSaved: (val) {},
          ),
          SizedBox(height: 10),
          TextFormField(
            initialValue: user.lastName,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Name",
              icon: Icon(Icons.account_circle),
            ),
            style: Theme.of(context).textTheme.bodyText1,
            validator: (val) {
              if (val == "") {
                return "Enter a valid name.";
              }
            },
            onSaved: (val) {},
          ),
          SizedBox(height: 10),
          TextFormField(
            initialValue: user.email,
            enabled: false,
            decoration: InputDecoration(
              hintText: "Name",
              icon: Icon(Icons.email),
            ),
            style: Theme.of(context).textTheme.bodyText1,
            validator: (val) {
              if (val == "") {
                return "Enter a valid name.";
              }
            },
            onSaved: (val) {},
          ),
          SizedBox(
            height: 30.0,
          ),
          FlatButton(
            child: Text("Sign out"),
            onPressed: () {
              //BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Sign out?"),
                      content: Text("Are you sure you want to sign out?"),
                      actions: [
                        RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutEvent());
                            },
                            child: Text("Yes")),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No")),
                      ],
                    );
                  });
            },
          ),
          Text("More features coming soon.")
        ],
      ),
    );
  }
}
