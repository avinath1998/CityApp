import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/bin_disposal/bin_disposal_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:citycollection/screens/general/take_picture_screen.dart';
import 'package:citycollection/screens/me/see_trash_disposals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:citycollection/extensions/date_time_extension.dart';

class GotTrashScreen extends StatefulWidget {
  static const routeName = "/GotTrashScreen";
  final TaggedBin selectedBin;

  const GotTrashScreen({Key key, this.selectedBin}) : super(key: key);

  @override
  _GotTrashScreenState createState() => _GotTrashScreenState();
}

class _GotTrashScreenState extends State<GotTrashScreen>
    with SingleTickerProviderStateMixin {
  final Logger logger = Logger("GotTrashScreen");
  bool _isLoading = false;
  TabController _tabController;
  File wasteImage;
  File binImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Got Trash?", style: TextStyle(color: Colors.black)),
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: BlocListener<BinDisposalBloc, BinDisposalState>(
          listener: (context, state) {
            logger.info(state);
            state.when(
                initial: () {},
                binDisposalsLoaded: (List<BinDisposal> disposals) {},
                binDisposalsLoading: () {},
                binDisposalsFailedLoading: () {},
                binDisposalFailedSaving: (Exception e) {
                  setState(() {
                    _isLoading = false;
                  });
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                          "An error has occured saving your disposal, try agan."),
                      actions: [
                        RaisedButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                },
                binDisposalSaved: (BinDisposal disposal) {
                  setState(() {
                    _isLoading = false;
                  });
                  _tabController.animateTo(4);
                },
                binDisposalSaving: () {
                  setState(() {
                    _isLoading = true;
                  });
                });
          },
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildingStartingTab(context),
              TakePictureScreen(
                icon: Icon(FontAwesomeIcons.trashAlt,
                    color: Colors.white, size: 40),
                message: "Take a picture of the trash bin.",
                title: "Take a picture of the bin.",
                iconTitle: "Trash Bin",
                onImageTaken: (file) {
                  _tabController.animateTo(2);
                  setState(() {
                    binImage = file;
                  });
                },
              ),
              TakePictureScreen(
                  icon: Icon(FontAwesomeIcons.wineBottle,
                      color: Colors.white, size: 40),
                  message: "Take a picture of your plastic trash.",
                  iconTitle: "Plastic Trash",
                  title: "Take a picture of your trash.",
                  onCameraInitialized: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EkvaAlertDialog(
                            title: "Plastics only!",
                            message:
                                "Take 1 picture of your plastic trash, only plastics allowed.",
                          );
                        });
                  },
                  onImageTaken: (file) {
                    _tabController.animateTo(3);
                    setState(() {
                      wasteImage = file;
                    });
                    BlocProvider.of<BinDisposalBloc>(context).add(
                        BinDisposalEvent.save(
                            widget.selectedBin,
                            binImage,
                            wasteImage,
                            BlocProvider.of<AuthBloc>(context).currentUser));
                  }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                          "Throw trash into bin while your disposal is being saved...",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ),
              ),
              _buildSuccessTab(context)
            ],
          ),
        )));
  }

  Padding _buildSuccessTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Thanks for your disposal!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: CityColors.primary_teal),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Your disposal is now under review.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Your Ekva points will be awarded once the pictures have been approved.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text("See Disposals"),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        SeeTrashDisposalsScreen.routeName);
                  },
                ),
                RaisedButton(
                  child: Text("Done"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildingStartingTab(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.recycle,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FontAwesomeIcons.wineBottle,
                  size: 40,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Got Trash?\nEarn Ekva Points!",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text("Throw it into this bin to earn Ekva points!",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1),
            SizedBox(
              height: 20,
            ),
            Text("We only accept plastic items only!",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "1. Take a ",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Icon(Icons.camera_alt),
                Text(
                  " of the trash bin.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "2. Take a ",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Icon(Icons.camera_alt),
                Text(
                  " of your trash (plastic).",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.selectedBin.imageSrc,
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: CircularProgressIndicator(),
                                ),
                                imageBuilder: (context, imageprovider) {
                                  return Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      image: DecorationImage(
                                        image: imageprovider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                widget.selectedBin.binName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Added by:\n" + widget.selectedBin.userName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/recycle_bin.png',
                          height: 50,
                          width: 50,
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "3. Throw your trash into the bin.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: RaisedButton(
                child: Text("Start"),
                onPressed: () {
                  _tabController.animateTo(1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
