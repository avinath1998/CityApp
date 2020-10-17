import 'dart:async';
import 'package:citycollection/blocs/location/location_bloc.dart';
import 'package:citycollection/blocs/nearby_bins/nearby_bins_bloc.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';

class NearbyTab extends StatefulWidget {
  @override
  _NearbyTabState createState() => _NearbyTabState();
}

class _NearbyTabState extends State<NearbyTab> {
  GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<Marker> _binMarkers = <Marker>[];
  final Logger logger = Logger("NearbyTabState");
  BitmapDescriptor pinLocationIcon;
  LocationBloc _locationBloc;
  bool _showLoading = false;

  @override
  void initState() {
    _locationBloc = LocationBloc();
    super.initState();
  }

  Future<BitmapDescriptor> _loadBinImage() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(60, 60)),
        'assets/images/recycle_bin.png');
  }

  @override
  void dispose() {
    _locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<NearbyBinsBloc, NearbyBinsState>(
        listener: (BuildContext context, state) async {
          if (state is CurrentLocationLoadingState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Center(child: CircularProgressIndicator()),
                  );
                });
            Navigator.of(context).pop();
          } else if (state is CurrentLocationLoadedState) {
            _mapController.moveCamera(CameraUpdate.newLatLng(
                LatLng(state.position.latitude, state.position.longitude)));
          } else if (state is CurrentLocationFailedState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content:
                        Center(child: Text("Failed to load current location.")),
                  );
                });
            Navigator.of(context).pop();
          } else if (state is BinsChangedState) {
            BitmapDescriptor image = await _loadBinImage();
            setState(() {
              _binMarkers.clear();
              state.taggedBins.forEach((taggedBin) {
                _binMarkers.add(Marker(
                    markerId: MarkerId(taggedBin.id),
                    icon: image,
                    position:
                        LatLng(taggedBin.locationLan, taggedBin.locationLon),
                    infoWindow: InfoWindow(
                      title: taggedBin.binName,
                    ),
                    onTap: () {
                      BlocProvider.of<NearbyBinsBloc>(context)
                          .add(SelectBinEvent(taggedBin));
                    }));
              });
            });
          } else if (state is BinChangeErrorState) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Whoops, something went wrong. :(")));
          }
        },
        child: Container(
          child: Stack(
            children: [
              BlocListener<LocationBloc, LocationState>(
                cubit: _locationBloc,
                listener: (conext, state) {
                  state.when(
                      initial: () {},
                      loadingLocationState: () {
                        if (!_showLoading) {
                          setState(() {
                            _showLoading = true;
                          });
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                  content: Container(
                                height: 60,
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Finding bins near you.")
                                  ],
                                ),
                              )));
                        }
                      },
                      loadedLocationState: (position, addresses) {
                        if (_showLoading) {
                          Navigator.of(context).pop();
                          setState(() {
                            _showLoading = false;
                          });
                        }
                        final p = CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 14.4746);
                        _mapController
                            .animateCamera(CameraUpdate.newCameraPosition(p));
                      },
                      failedLoadingLocationState: () {
                        if (_showLoading) {
                          Navigator.of(context).pop();
                          setState(() {
                            _showLoading = false;
                          });
                        }
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            child: EkvaAlertDialog(
                              message:
                                  "Could not get your lcoation, try again.",
                              title: "Something went wrong...",
                            ));
                      },
                      locationDisabledState: () {
                        if (_showLoading) {
                          Navigator.of(context).pop();
                          setState(() {
                            _showLoading = false;
                          });
                        }
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            child: EkvaAlertDialog(
                              message:
                                  "Your location permission is disabled, enable it and try again.",
                              title: "Something went wrong...",
                            ));
                      },
                      locationDeniedState: () {
                        if (_showLoading) {
                          Navigator.of(context).pop();
                          setState(() {
                            _showLoading = false;
                          });
                        }
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            child: EkvaAlertDialog(
                              message:
                                  "Your location permission is disabled, enable it and try again.",
                              title: "Something went wrong...",
                            ));
                      },
                      locationServicesOffState: () {
                        logger
                            .info("Location Services are off, showing dialog");
                        if (_showLoading) {
                          Navigator.of(context).pop();
                          setState(() {
                            _showLoading = false;
                          });
                        }
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            child: EkvaAlertDialog(
                              message:
                                  "Your location services, enable it and try again.",
                              title: "Something went wrong...",
                            ));
                      });
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                      onPressed: () {
                        _locationBloc.add(LocationEvent.loadLocationEvent());
                      },
                      child: Icon(Icons.location_searching),
                    ),
                  ),
                ),
              ),
              GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: Set<Marker>.of(_binMarkers),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _mapController = controller;
                },
              ),
              NearbyButton(
                onLocationFound: (position) {
                  final p = CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 14.4746);
                  _mapController
                      .animateCamera(CameraUpdate.newCameraPosition(p));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyButton extends StatefulWidget {
  final Function(Position position) onLocationFound;

  const NearbyButton({Key key, this.onLocationFound}) : super(key: key);
  @override
  _NearbyButtonState createState() => _NearbyButtonState();
}

class _NearbyButtonState extends State<NearbyButton> {
  bool _showLoading = false;
  LocationBloc _locationBloc;
  final Logger logger = Logger("NearbyButtonState");

  @override
  void initState() {
    super.initState();
    _locationBloc = LocationBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _locationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      cubit: _locationBloc,
      listener: (conext, state) {
        state.when(
            initial: () {},
            loadingLocationState: () {
              setState(() {
                _showLoading = true;
              });
            },
            loadedLocationState: (position, addresses) {
              setState(() {
                _showLoading = false;
              });
              widget.onLocationFound(position);
            },
            failedLoadingLocationState: () {
              setState(() {
                _showLoading = false;
              });
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     child: EkvaAlertDialog(
              //       message: "Could not get your lcoation, try again.",
              //       title: "Something went wrong...",
              //     ));
            },
            locationDisabledState: () {
              setState(() {
                _showLoading = false;
              });
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     child: EkvaAlertDialog(
              //       message:
              //           "Your location permission is disabled, enable it and try again.",
              //       title: "Something went wrong...",
              //     ));
            },
            locationDeniedState: () {
              setState(() {
                _showLoading = false;
              });
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     child: EkvaAlertDialog(
              //       message:
              //           "Your location permission is disabled, enable it and try again.",
              //       title: "Something went wrong...",
              //     ));
            },
            locationServicesOffState: () {
              setState(() {
                _showLoading = false;
              });
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     child: EkvaAlertDialog(
              //       message:
              //           "Your location services is disabled, enable it and try again.",
              //       title: "Couldn't find bins...",
              //     ));
            });
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: !_showLoading
              ? RaisedButton(
                  onPressed: () {
                    _locationBloc.add(LocationEvent.loadLocationEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.location_searching),
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
