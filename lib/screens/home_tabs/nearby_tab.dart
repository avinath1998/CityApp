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
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("Under development",
                      style: Theme.of(context).textTheme.subhead),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
