import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';

class MeTab extends StatefulWidget {
  @override
  _MeTabState createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          snap: true,
          floating: true,
          title: Container(
              child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: [
              TextSpan(
                  text: "Next", style: Theme.of(context).textTheme.display1),
              TextSpan(
                  text: "PickUp:", style: Theme.of(context).textTheme.display2),
            ]),
          )),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Card(
                child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("6 x PET Bottles",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text("2 x E-Waste",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("6km away",
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {},
                        child: Text(
                          "Confirm Pickup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {},
                        child: Text(
                          "Cancel Pickup",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: CityColors.primary_green,
                    onPressed: () {},
                    child: Text(
                      "View on Map",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    color: CityColors.primary_green,
                    onPressed: () {},
                    child: Text(
                      "Call Owner",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
            Container(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Later",
                            style: Theme.of(context).textTheme.display1),
                        TextSpan(
                            text: "PickUps",
                            style: Theme.of(context).textTheme.display2),
                      ]),
                    ))),
            Card(
                child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("2 x Glass Bottles",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text("1 x E-Waste",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("10km away",
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Card(
                child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("2 x Glass Bottles",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text("10 x E-Waste",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("12km away",
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ]),
        )
      ],
    );
  }
}
