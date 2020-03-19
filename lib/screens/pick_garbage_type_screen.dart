import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickGarbageTypeScreen extends StatefulWidget {
  final String pickup_slot;

  PickGarbageTypeScreen({Key key, this.pickup_slot}) : super(key: key);
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
                      style: Theme.of(context).textTheme.display1),
                  TextSpan(
                      text: "Slot: ",
                      style: Theme.of(context).textTheme.display2),
                  TextSpan(
                      text: widget.pickup_slot,
                      style: Theme.of(context).textTheme.display1),
                ]),
              )),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return _createRedemptionCard(items[index]);
              }, childCount: items.length),
            )
          ],
        ));
  }

  final List<String> items = [
    'PET Bottles',
    'Milk Packets',
    'Juice Boxes',
    'Paper Items',
    "Tin Cans",
    "Cardboard Boxes",
    "E-waste Items",
    "Plastic Items",
    "Glass Items",
    "Flip-Flops"
  ];

  Widget _createRedemptionCard(String text) {
    return InkWell(
      onTap: () {},
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
            Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            )
          ],
        )),
        height: 100.0,
      ),
    );
  }
}
