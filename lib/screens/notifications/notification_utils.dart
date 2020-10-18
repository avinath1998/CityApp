import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/notifications/add_bin_notification/add_bin_notification.dart';
import 'package:citycollection/models/notifications/disposal_notification/disposal_notification.dart';
import 'package:citycollection/models/notifications/general_notification/general_notification.dart';
import 'package:citycollection/models/notifications/prize_notification/prize_notification.dart';
import 'package:citycollection/models/prize.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showGeneralNotification({context, GeneralNotification notif}) {
  Flushbar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    borderRadius: 20,
    animationDuration: Duration(milliseconds: 400),
    margin: const EdgeInsets.all(10),
    boxShadows: [
      BoxShadow(
          blurRadius: 4,
          spreadRadius: 0.3,
          color: Colors.black12,
          offset: Offset(0.0, 0.0)),
    ],
    icon: Icon(Icons.notifications),
    titleText: Text(
      notif.title,
      style: Theme.of(context).textTheme.subtitle1,
    ),
    messageText: Text(
      notif.body,
      style: Theme.of(context).textTheme.bodyText1,
    ),
    isDismissible: true,
    duration: Duration(seconds: 5),
  )..show(context);
}

void showPrizeNotification(
    {context, PrizeNotification notif, Function() onSeeRedemptionsTapped}) {
  Flushbar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    borderRadius: 20,
    animationDuration: Duration(milliseconds: 400),
    margin: const EdgeInsets.all(10),
    boxShadows: [
      BoxShadow(
          blurRadius: 4,
          spreadRadius: 0.3,
          color: Colors.black12,
          offset: Offset(0.0, 0.0)),
    ],
    icon: Icon(Icons.notifications),
    messageText: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: notif.imageSrc,
              placeholder: (context, url) => CircularProgressIndicator(),
              imageBuilder: (context, provider) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(fit: BoxFit.cover, image: provider)),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: notif.status == PrizeRedemptionStatus.delivered
                            ? CityColors.primary_teal
                            : Colors.red),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    notif.body,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      child: Text("See Redemptions"),
                      onPressed: onSeeRedemptionsTapped,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    isDismissible: true,
    duration: Duration(seconds: 5),
  )..show(context);
}

void showBinNotification(
    {context, AddBinNotification notif, Function() onSeeBinsTapped}) {
  Flushbar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    borderRadius: 20,
    animationDuration: Duration(milliseconds: 400),
    margin: const EdgeInsets.all(10),
    boxShadows: [
      BoxShadow(
          blurRadius: 4,
          spreadRadius: 0.3,
          color: Colors.black12,
          offset: Offset(0.0, 0.0)),
    ],
    icon: Icon(Icons.notifications),
    messageText: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: notif.imageSrc,
              placeholder: (context, url) => CircularProgressIndicator(),
              imageBuilder: (context, provider) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(fit: BoxFit.cover, image: provider)),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: notif.isBinLive == "false"
                            ? Colors.red
                            : CityColors.primary_teal),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    notif.body,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      child: Text("See Bins"),
                      onPressed: onSeeBinsTapped,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    isDismissible: true,
    duration: Duration(seconds: 5),
  )..show(context);
}

void showDisposalNotification(
    {context, DisposalNotification notif, Function() onSeeDisposalsTapped}) {
  Flushbar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    borderRadius: 20,
    animationDuration: Duration(milliseconds: 400),
    margin: const EdgeInsets.all(10),
    boxShadows: [
      BoxShadow(
          blurRadius: 4,
          spreadRadius: 0.3,
          color: Colors.black12,
          offset: Offset(0.0, 0.0)),
    ],
    icon: Icon(Icons.notifications),
    messageText: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: notif.imageSrc,
              placeholder: (context, url) => CircularProgressIndicator(),
              imageBuilder: (context, provider) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(fit: BoxFit.cover, image: provider)),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif.title,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: notif.status == BinDisposalStatus.approved
                              ? CityColors.primary_teal
                              : Colors.red)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    notif.body,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      child: Text("See Disposals"),
                      onPressed: onSeeDisposalsTapped,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    isDismissible: true,
    duration: Duration(seconds: 5),
  )..show(context);
}
