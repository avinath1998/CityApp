import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../pick_garbage_type_screen.dart';

class ScheduleTab extends StatefulWidget {
  @override
  _ScheduleTabState createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  String currentSelectedDay = "Sunday";
  final List<String> _days = [
    "Sunday @ 9:30am",
    "Monday @ 9:30am",
    "Tuesday @ 9:30am",
    "Tuesday @ 4:30pm",
    "Wednesday @ 9:30am",
    "Thursday @ 9:30am",
    "Friday @ 9:30am",
    "Saturday @ 9:30am"
        "Saturday @ 4:30pm"
  ];

  final List<String> _timeslots = ["4:30pm", "4:30pm", "4:30pm", "4:30pm"];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          snap: true,
          floating: true,
          title: Container(
              child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: [
              TextSpan(
                  text: "Pick", style: Theme.of(context).textTheme.display1),
              TextSpan(text: "A", style: Theme.of(context).textTheme.display2),
              TextSpan(
                  text: "PickUp", style: Theme.of(context).textTheme.display1),
              TextSpan(
                  text: "Slot", style: Theme.of(context).textTheme.display2),
            ]),
          )),
        ),
        _createHeader("Sunday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Monday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Tuesday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Wednesday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Thursday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Friday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
        _createHeader("Saturday"),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createDayCard("10:30am"),
              _createDayCard("4:30pm"),
            ]),
          ),
        ),
      ],
    ));
  }

  Widget _createHeader(String text) {
    return SliverStickyHeader(
      header: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 4,
              spreadRadius: 0.3,
              color: Colors.black12,
              offset: Offset(0.0, 0.0)),
        ]),
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.display3,
        ),
      ),
    );
  }

  Widget _createDayCard(String time) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickGarbageTypeScreen(
                      pickup_slot: time,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.all(3.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _createRedemptionCard(IconData iconData, Function onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: CityColors.primary_green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Container(
//               padding: const EdgeInsets.all(20.0),
//               child: GridView(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 5.0,
//                   mainAxisSpacing: 5.0,
//                 ),
//                 children: <Widget>[
//                   _createRedemptionCard(Icons.tab, () {
//                     print("we");
//                   })
//                 ],
//               ))
