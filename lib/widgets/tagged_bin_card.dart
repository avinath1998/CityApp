import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:citycollection/widgets/bottom_sheet_edit_bin.dart';
import 'package:flutter/material.dart';

import 'package:citycollection/models/tagged_bin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

class TaggedBinCard extends StatefulWidget {
  final TaggedBin bin;
  final Function(TaggedBin) onBinUpdated;

  const TaggedBinCard({
    Key key,
    this.bin,
    this.onBinUpdated,
  }) : super(key: key);

  @override
  _TaggedBinCardState createState() => _TaggedBinCardState();
}

class _TaggedBinCardState extends State<TaggedBinCard> {
  TaggedBin bin;
  bool _showEditBinOptions = false;
  final Logger logger = Logger("TaggedBinCardState");
  TaggedBinsBloc _taggedBinsBloc;
  double height = 200;

  @override
  void initState() {
    super.initState();
    _taggedBinsBloc = TaggedBinsBloc(GetIt.instance<DataRepository>());
    bin = widget.bin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "Disposals by others: 4",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        bin.active ? "Live on map" : "Pending review",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: bin.active ? Colors.green : Colors.orange),
                      ),
                    ],
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
                    setState(() {
                      logger.info("Editing");
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
