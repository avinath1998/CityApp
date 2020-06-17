import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupConfirmationScreen extends StatefulWidget {
  final List<String> items;
  final List<double> count;
  final String time;
  final String date;

  const PickupConfirmationScreen(
      {Key key, this.items, this.count, this.time, this.date})
      : super(key: key);

  @override
  _PickupConfirmationScreenState createState() =>
      _PickupConfirmationScreenState();
}

class _PickupConfirmationScreenState extends State<PickupConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Pickup",
                      style: Theme.of(context).textTheme.headline1),
                  TextSpan(
                      text: "Confirmed",
                      style: Theme.of(context).textTheme.headline2),
                ]),
              )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CityColors.primary_green,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                  "Thanks for scheduling a pickup!\nHere are your pickup details",
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Pickup: ",
                      style: Theme.of(context).textTheme.subtitle1),
                  TextSpan(
                      text: "${widget.time}",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 23.0)),
                  TextSpan(
                      text: " on ",
                      style: Theme.of(context).textTheme.subtitle1),
                  TextSpan(
                      text: "${widget.date}",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 23.0))
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Items",
                    style: Theme.of(context).textTheme.subtitle1),
                TextSpan(
                    text: "Declared:",
                    style: Theme.of(context).textTheme.subtitle2)
              ])),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (widget.count[index] == 0.0) {
                    return Container();
                  }
                  if (widget.items[index] != "PET Bottles") {
                    return Text(
                      widget.items[index] +
                          " x " +
                          widget.count[index].ceil().toString() +
                          "kg",
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      widget.items[index] +
                          " x " +
                          widget.count[index].ceil().toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
                itemCount: widget.items.length,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                color: CityColors.primary_green,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
