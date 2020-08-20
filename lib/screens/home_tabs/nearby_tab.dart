import 'dart:async';
import 'package:citycollection/blocs/nearby_bins/nearby_bins_bloc.dart';
import 'package:citycollection/networking/data_repository.dart';
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
  bool _isBinsStreamOpen = false;
  List<Marker> _binMarkers = <Marker>[];
  final Logger logger = Logger("NearbyTabState");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<NearbyBinsBloc, NearbyBinsState>(
        listener: (BuildContext context, state) {
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
            setState(() {
              _binMarkers.clear();
              state.taggedBins.forEach((taggedBin) {
                _binMarkers.add(Marker(
                    markerId: MarkerId(taggedBin.id),
                    position:
                        LatLng(taggedBin.locationLan, taggedBin.locationLon),
                    infoWindow: InfoWindow(title: taggedBin.binName),
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
          child: GoogleMap(
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
        ),
      ),
    );
  }
}
