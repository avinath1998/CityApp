import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/configurations.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/redemption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedemptionsScreen extends StatefulWidget {
  static const routeName = "/redemptions";

  @override
  _RedemptionsScreenState createState() => _RedemptionsScreenState();
}

class _RedemptionsScreenState extends State<RedemptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "My Redemptions",
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("redemptions")
            .where("userId",
                isEqualTo: BlocProvider.of<AuthBloc>(context).currentUser.id)
            .orderBy("redeemTime", descending: true)
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text("An error has occured, try again."));
          }
          switch (snap.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("An error has occured, come back later."),
              );
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              if (snap.data.documents.length == 0) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: Text(
                        "You haven't made any redemptions yet.\n Earn Ekva Points to redeem a prize!",
                        textAlign: TextAlign.center,
                      )),
                      RaisedButton(
                        child: Text("Go Back"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              }
              return Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = snap.data.documents[index].data;
                    map["id"] = snap.data.documents[index].documentID;
                    Redemption redemption =
                        Redemption.fromJson(snap.data.documents[index].data);
                    return _buildRedemptionCard(redemption);
                  },
                  itemCount: snap.data.documents.length,
                ),
              );
              break;
            case ConnectionState.done:
              return Center(
                child: Text("An error has occured, come back later."),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildRedemptionCard(Redemption redemption) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: redemption.image,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              ),
                              imageBuilder: (context, imageprovider) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                      image: imageprovider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  redemption.title,
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Cost: ${redemption.cost}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Redeemed on: ${Configurations.dateFormatter.format(redemption.redeemTime)}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text("Status: "),
                                    Flexible(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          switch (redemption.status) {
                                            case PrizeRedemptionStatus
                                                .delivered:
                                              return Text("Delivered",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(
                                                          color: Colors.green));
                                              break;
                                            case PrizeRedemptionStatus
                                                .notEnoughPoints:
                                              return Text(
                                                "Declined, points refunded.",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .errorColor),
                                              );
                                              break;
                                            case PrizeRedemptionStatus
                                                .couponCodesFinished:
                                              return Text(
                                                "Declined, points refunded.",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .errorColor),
                                              );
                                              break;
                                            case PrizeRedemptionStatus
                                                .disallowed:
                                              return Text(
                                                "Declined, points refunded.",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .errorColor),
                                              );
                                              break;
                                            case PrizeRedemptionStatus.waiting:
                                              return Text("Pending",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(
                                                        color: Colors.orange,
                                                      ));
                                              break;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    switch (redemption.status) {
                                      case PrizeRedemptionStatus.delivered:
                                        return Align(
                                          alignment: Alignment.bottomRight,
                                          child: RaisedButton(
                                            child: Text("See Code"),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return EkvaAlertDialog(
                                                    title: "Your Prize Code",
                                                    message:
                                                        "Your code is \n ${redemption.code}\n\n${redemption.message}",
                                                    onOkPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                        break;
                                      case PrizeRedemptionStatus
                                          .notEnoughPoints:
                                        if (redemption.message != null) {
                                          return Text(redemption.message);
                                        }
                                        break;
                                      case PrizeRedemptionStatus
                                          .couponCodesFinished:
                                        if (redemption.message != null) {
                                          return Text(redemption.message);
                                        }
                                        break;
                                      case PrizeRedemptionStatus.disallowed:
                                        if (redemption.message != null) {
                                          return Text(redemption.message);
                                        }
                                        break;
                                      case PrizeRedemptionStatus.waiting:
                                        if (redemption.message != null) {
                                          return Text(redemption.message);
                                        }
                                        break;
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            )),
      ),
    );
  }
}
