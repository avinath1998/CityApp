import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/blocs/redeem_prize/redeem_prize_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/redemption.dart';
import 'package:citycollection/screens/me/redemptions_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemDialog extends StatefulWidget {
  final Prize prize;
  final CurrentUser user;
  final Function() onRedeemed;
  const RedeemDialog({Key key, this.prize, this.user, this.onRedeemed})
      : super(key: key);

  @override
  _RedeemDialogState createState() => _RedeemDialogState();
}

class _RedeemDialogState extends State<RedeemDialog> {
  RedeemPrizeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = RedeemPrizeBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: Key(widget.prize.id),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.prize.image,
              imageBuilder: (context, provider) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(fit: BoxFit.cover, image: provider)),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.prize.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.prize.desc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            BlocBuilder(
                cubit: _bloc,
                builder: (context, state) {
                  if (state is RedeemPrizeInitial) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          color: CityColors.primary_teal,
                          onPressed: () {
                            _bloc.add(RedeemCityPrizeEvent(
                                widget.prize, widget.user));
                          },
                          child: Text(
                            "Confirm Redemption",
                          ),
                        ),
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  } else if (state is PrizeRedeemedWaitingState) {
                    return CircularProgressIndicator();
                  } else if (state is PrizeRedeemedFailedState) {
                    switch (state.status) {
                      case PrizeRedemptionStatus.delivered:
                        return Center(
                            child: Text(
                          "Whoops, an error has occured, try again",
                          textAlign: TextAlign.center,
                        ));
                        break;
                      case PrizeRedemptionStatus.notEnoughPoints:
                        return Center(
                            child: Text(
                                "Whoops, an error has occured, try again",
                                textAlign: TextAlign.center));
                        break;
                      case PrizeRedemptionStatus.couponCodesFinished:
                        return Center(
                            child: Text(
                                "Oh no! We just ran out of this prize, try another one. Sorry :(",
                                textAlign: TextAlign.center));
                        break;
                      case PrizeRedemptionStatus.disallowed:
                        return Center(
                            child: Text(
                          "Whoops, an error has occured, try again",
                          textAlign: TextAlign.center,
                        ));
                        break;
                      case PrizeRedemptionStatus.waiting:
                        return Center(
                            child: Text(
                          "Whoops, an error has occured, try again",
                          textAlign: TextAlign.center,
                        ));
                        break;
                    }
                  } else if (state is PrizeRedeemedSuccessState) {
                    if (widget.onRedeemed != null) {
                      widget.onRedeemed();
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: FlareActor("assets/flare/trophy.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "show"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Redemption status: ",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Pending",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.orangeAccent),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Redemtion request sent, go to redemptions page to see its status.\nSomeone from our team will approve it soon.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          child: Text("Go to Redemptions"),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                RedemptionsScreen.routeName);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
                }),
          ])),
    );
  }
}
