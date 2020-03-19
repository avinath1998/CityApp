import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';

class NearbyTab extends StatefulWidget {
  @override
  _NearbyTabState createState() => _NearbyTabState();
}

class _NearbyTabState extends State<NearbyTab> {
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
                  text: "User ID: ",
                  style: Theme.of(context).textTheme.display1),
              TextSpan(
                  text: "13124 ", style: Theme.of(context).textTheme.display2),
            ]),
          )),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("Declared: 6 PET Bottles",
                      style: Theme.of(context).textTheme.subhead),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  color: CityColors.primary_green,
                  padding: const EdgeInsets.all(20.0),
                  onPressed: () {},
                  child: Text(
                    "YES",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  color: Colors.red,
                  padding: const EdgeInsets.all(20.0),
                  onPressed: () {},
                  child: Text(
                    "NO",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  color: Colors.green,
                  padding: const EdgeInsets.all(15.0),
                  onPressed: () {},
                  child: Text(
                    "Next Declaration",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
