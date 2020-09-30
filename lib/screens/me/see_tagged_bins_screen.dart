import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/widgets/bottom_sheet_edit_bin.dart';
import 'package:citycollection/widgets/tagged_bin_card.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("My Tagged Bins")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("taggedBins")
            .where("userId",
                isEqualTo: BlocProvider.of<AuthBloc>(context).currentUser.id)
            .orderBy("taggedTime", descending: true)
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
              if (snap.hasError) {
                return Center(
                    child: Text("An error has occured loading your bins."));
              } else if (snap.hasData) {
                return Scrollbar(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snap.data.docs[index].data();
                      map["id"] = snap.data.docs[index].id;
                      TaggedBin bin = TaggedBin.fromJson(map);
                      if (bin.binName != null)
                        return _buildTaggedBinCard(bin);
                      else
                        return Container();
                    },
                    itemCount: snap.data.docs.length,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
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
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                              imageUrl: bin.imageSrc,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            bin.binName,
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Disposals for bin: ${bin.disposalsMade}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            bin.active ? "Live on map" : "Pending review",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: bin.active
                                        ? Colors.green
                                        : Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
          return BottomSheetEditBin(bin: bin, scrollController: null);
        });

    if (binUpdated != null) {
      BlocProvider.of<TaggedBinsBloc>(context).add(EditTaggedBinEvent(
          BlocProvider.of<AuthBloc>(context).currentUser, binUpdated));
    }
  }
}
