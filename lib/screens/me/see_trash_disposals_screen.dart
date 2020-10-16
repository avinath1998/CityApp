import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:citycollection/extensions/date_time_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeeTrashDisposalsScreen extends StatefulWidget {
  static const routeName = "/seeTrashDisposalsScreen";
  @override
  _SeeTrashDisposalsScreenState createState() =>
      _SeeTrashDisposalsScreenState();
}

class _SeeTrashDisposalsScreenState extends State<SeeTrashDisposalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Disposals")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("binDisposals")
            .where("userId",
                isEqualTo: BlocProvider.of<AuthBloc>(context).currentUser.id)
            .orderBy("disposalTime", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("An error has occured, try agin."));
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              if (snap.hasData) {
                if (snap.data.docs.length > 0) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snap.data.docs[index].data();
                        map["id"] = snap.data.docs[index].id;
                        return _buildTrashDisposals(BinDisposal.fromJson(map));
                      },
                      itemCount: snap.data.docs.length);
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "You haven't made a disposal, find an Ekva bin and make one!",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          child: Text("Go Back"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ));
                }
              } else if (snap.hasError) {
                return Center(child: Text("An error has occured, try again"));
              }
              break;
            case ConnectionState.done:
              return Center(child: Text("An error has occured, try again"));
              break;
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTrashDisposals(BinDisposal binDisposal) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CachedNetworkImage(
                      imageUrl: binDisposal.binImageSrc,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      ),
                      imageBuilder: (context, imageprovider) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
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
                            ),
                            Text(
                              "Bin",
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        );
                      },
                    ),
                    CachedNetworkImage(
                      imageUrl: binDisposal.wasteImageSrc,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      ),
                      imageBuilder: (context, imageprovider) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
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
                            ),
                            Text(
                              "Waste",
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Disposed on " + binDisposal.disposalTime.toDateString(),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Bin name: ${binDisposal.binName}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    switch (binDisposal.status) {
                      case BinDisposalStatus.pending:
                        return Text("Pending Review",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.orange));
                        break;
                      case BinDisposalStatus.approved:
                        return Text(
                          "Approved, you've earned ${binDisposal.pointAmount} Ekva points.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.green),
                        );
                        break;
                      case BinDisposalStatus.disapproved:
                        return Column(
                          children: [
                            Text(
                              "Disposal disapproved!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.red),
                            ),
                            FlatButton(
                              child: Text("See reason"),
                              onPressed: () {
                                showDialog(
                                    builder: (context) {
                                      return EkvaAlertDialog(
                                        title: "Disposal disapproved",
                                        message: binDisposal.message,
                                        onOkPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                    context: context);
                              },
                            )
                          ],
                        );
                        break;
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
