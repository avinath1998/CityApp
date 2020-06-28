import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/garbage_type.dart';
import 'package:citycollection/models/pickup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupConfirmationScreen extends StatefulWidget {
  final List<GarbageType> selectedGarbageType;
  final Pickup pickup;

  const PickupConfirmationScreen({
    Key key,
    this.selectedGarbageType,
    this.pickup,
  }) : super(key: key);

  @override
  _PickupConfirmationScreenState createState() =>
      _PickupConfirmationScreenState();
}

class _PickupConfirmationScreenState extends State<PickupConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Confirmed",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0))
          ]),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Pickup",
                    style: Theme.of(context).textTheme.display2),
                TextSpan(
                    text: "Confirmed",
                    style: Theme.of(context).textTheme.display1),
              ]),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: CityColors.primary_green),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Thanks for scheduling a pickup!\nHere are your pickup details.",
              style: TextStyle(fontSize: 17.0),
              textAlign: TextAlign.start,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Pickup: ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0),
                  ),
                  Text(
                    widget.pickup.time,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " on ",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    widget.pickup.day,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Items",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 25.0)),
                TextSpan(
                    text: "Declared:",
                    style: Theme.of(context)
                        .textTheme
                        .display2
                        .copyWith(fontSize: 25.0)),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      Text(
                        widget.selectedGarbageType[index].garbageType + " x",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Text(
                        widget.selectedGarbageType[index].count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20.0),
                      )
                    ],
                  );
                },
                itemCount: widget.selectedGarbageType.length,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
                child: RaisedButton(
              color: CityColors.primary_green,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Text(
                "Done",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ))
          ],
        ),
      ),
    );
  }
}
