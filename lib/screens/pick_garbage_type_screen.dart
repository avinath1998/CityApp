import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/pickup_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class PickGarbageTypeScreen extends StatefulWidget {
  final String pickup_slot;
  final String pickup_date;

  PickGarbageTypeScreen({Key key, this.pickup_slot, this.pickup_date})
      : super(key: key);
  @override
  _PickGarbageTypeScreenState createState() => _PickGarbageTypeScreenState();
}

class _PickGarbageTypeScreenState extends State<PickGarbageTypeScreen> {
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
                  text: "Add Items",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0))
            ]),
          ),
        ),
        body: CustomScrollView(
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
                      text: "Selected",
                      style: Theme.of(context).textTheme.headline1),
                  TextSpan(
                      text: "Slot: ",
                      style: Theme.of(context).textTheme.headline2),
                  TextSpan(
                      text: widget.pickup_slot,
                      style: Theme.of(context).textTheme.headline1),
                ]),
              )),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      items[index] == "PET Bottles"
                          ? Container(
                              margin:
                                  const EdgeInsets.only(left: 20.0, top: 30.0),
                              child: Text(
                                "Specify the number of PET bottles you have here.",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0),
                        child: items[index] != "PET Bottles"
                            ? Text(
                                items[index] + " (kg)",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              )
                            : Text(
                                items[index] + " (Count)",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: FluidSlider(
                          key: Key(items[index]),
                          sliderColor: CityColors.primary_green,
                          labelsTextStyle: TextStyle(color: Colors.white),
                          value: itemCount[index],
                          thumbDiameter: 40,
                          valueTextStyle: GoogleFonts.poppins(fontSize: 20.0),
                          onChanged: (double newValue) {
                            setState(() {
                              itemCount[index] = newValue;
                            });
                          },
                          min: 0.0,
                          max: 50.0,
                        ),
                      ),
                      items[index] == "PET Bottles"
                          ? Container(
                              margin:
                                  const EdgeInsets.only(left: 20.0, top: 30.0),
                              child: Text(
                                "Specify the kilograms of each waste below. (Approximately)",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
              childCount: items.length,
            )),
            SliverToBoxAdapter(
                child: Container(
              margin: const EdgeInsets.all(20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                color: CityColors.primary_green,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PickupConfirmationScreen(
                      items: items,
                      count: itemCount,
                      time: widget.pickup_slot,
                      date: widget.pickup_date,
                    ),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "Confirm Pickup",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )),
          ],
        ));
  }

  final List<String> items = [
    'PET Bottles',
    'Paper Items',
    "Metal Items",
    "Plastic Items",
    "Glass Items",
  ];

  final List<double> itemCount = [0, 0, 0, 0, 0];

  Widget _createRedemptionCard(String text, int ind) {
    return InkWell(
      onTap: () {
        setState(() {
          itemCount[ind] += 1;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: CityColors.primary_green,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                itemCount[ind] != 0
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      )
                    : Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                itemCount[ind] != 0
                    ? Text(
                        itemCount[ind].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                    : Container(),
              ],
            ),
          ],
        )),
        height: 100.0,
      ),
    );
  }
}
