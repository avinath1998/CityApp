import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerTab extends StatefulWidget {
  const QrScannerTab({
    Key key,
    @required bool hasQrCodeBeenFound,
    @required GlobalKey<State<StatefulWidget>> qrKey,
    @required ScanBloc scanBloc,
    @required this.context,
  })  : _hasQrCodeBeenFound = hasQrCodeBeenFound,
        _qrKey = qrKey,
        _scanBloc = scanBloc,
        super(key: key);

  final bool _hasQrCodeBeenFound;
  final GlobalKey<State<StatefulWidget>> _qrKey;
  final ScanBloc _scanBloc;
  final BuildContext context;

  @override
  _QrScannerTabState createState() => _QrScannerTabState();
}

class _QrScannerTabState extends State<QrScannerTab> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInExpo,
      switchInCurve: Curves.easeOutExpo,
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: !widget._hasQrCodeBeenFound
          ? Stack(
              children: <Widget>[
                QRView(
                  key: widget._qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    widget._scanBloc.add(QRViewCreatedEvent(controller));
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Scan QR",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Scan QR on bin.",
                              key: ValueKey("pointText"),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              key: ValueKey("findingColumn"),
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Loading(
                                      indicator: LineScaleIndicator(),
                                      size: 30,
                                      color: Colors.white),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Finding QR code...",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Loading(
                      indicator: BallGridPulseIndicator(),
                      size: 60,
                      color: Colors.white),
                )
              ],
            )
          : Column(
              key: ValueKey("QrFoundScanKey"),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CityColors.primary_teal,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "QR Code Found.",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
    );
  }
}
