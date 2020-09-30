import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LeaderboardTab extends StatefulWidget {
  final ScrollController scrollController;

  const LeaderboardTab({Key key, this.scrollController}) : super(key: key);
  @override
  _LeaderboardTabState createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                child: FlareActor("assets/flare/trophy.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "show"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "See the champions around you soon!",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
