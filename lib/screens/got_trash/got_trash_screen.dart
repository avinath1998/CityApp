import 'dart:io';

import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/bin_disposal/bin_disposal_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:citycollection/screens/general/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';

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
                icon:
                    Icon(FontAwesomeIcons.trash, color: Colors.white, size: 40),
                message: "Take a picture of the trash bin.",
                onImageTaken: (file) {
                  _tabController.animateTo(2);
                  setState(() {
                    binImage = file;
                  });
                },
              ),
              TakePictureScreen(
                  icon: Icon(FontAwesomeIcons.trash,
                      color: Colors.white, size: 40),
                  message: "Take a picture of your trash.",
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Saving your disposal...",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
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
            RaisedButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
            Text(
              "Got Trash?",
              style: Theme.of(context).textTheme.headline4,
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
            Text(
              "1. Take a picture of your trash (Plastics).",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "2. Take a picture of the bin you selected:\n${widget.selectedBin.binName}.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
