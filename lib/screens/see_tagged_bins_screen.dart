import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/widgets/bottom_sheet_edit_bin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SeeTaggedBinsScreen extends StatefulWidget {
  static const routeName = "/seetagged";

  @override
  _SeeTaggedBinsScreenState createState() => _SeeTaggedBinsScreenState();
}

class _SeeTaggedBinsScreenState extends State<SeeTaggedBinsScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tagged Bins")),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("taggedBins")
            .where("userId",
                isEqualTo: BlocProvider.of<AuthBloc>(context).currentUser.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: Text(
                      "An error has occured loading your bins, try again"));
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
              return Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = snap.data.documents[index].data;
                    map["id"] = snap.data.documents[index].documentID;
                    TaggedBin bin =
                        TaggedBin.fromJson(snap.data.documents[index].data);
                    if (bin.binName != null)
                      return _buildTaggedBinCard(bin);
                    else
                      return Container();
                  },
                  itemCount: snap.data.documents.length,
                ),
              );
              break;
            case ConnectionState.done:
              return Center(
                  child: Text(
                      "An error has occured loading your bins, try again"));
              break;
          }
        },
      ),
    );
  }

  Widget _buildTaggedBinCard(TaggedBin bin) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Container(
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
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: bin.imageSrc,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              ),
                              imageBuilder: (context, imageprovider) {
                                return Container(
                                  height: 140,
                                  width: 160,
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bin.binName,
                                  style: Theme.of(context).textTheme.headline5,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                    bin.active
                                        ? "Live on map"
                                        : "Pending review",
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                Text("Disposals by others: 4",
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                      child: Text("Remove Bin"),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text("Edit Bin"),
                      onPressed: () {
                        _initBinUpload(bin);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            )),
      ),
    );
  }

  void _initBinUpload(TaggedBin bin) async {
    TaggedBin binUpdated = await showModalBottomSheet<TaggedBin>(
        context: context,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (
          context,
        ) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: BottomSheetEditBin(bin: bin, scrollController: null),
          );
        });
    // TaggedBin binName = await showDialog<TaggedBin>(
    //     context: context,
    //     builder: (context) {
    //       //camera tab
    //     });
    // if (binName != null) {
    //   BlocProvider.of<TaggedBinsBloc>(context).add(EditTaggedBinEvent(
    //       BlocProvider.of<AuthBloc>(context).currentUser, binName));
    // }
  }
}
