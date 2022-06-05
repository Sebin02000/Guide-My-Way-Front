import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/provider/location/google.dart';
import 'package:maps_app/provider/location/location_services.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class G_map extends StatefulWidget {
  const G_map({
    Key? key,
  }) : super(key: key);

  // ignore: unused_field

  @override
  State<G_map> createState() => _G_mapState();
}

CameraPosition _camPossition = const CameraPosition(
  target: LatLng(0, 0),
  zoom: 2,
);
double oldLat = 0;
bool isFesh = true;
List<Marker> mar = [];
List<Circle> circles = [];

// ignore: camel_case_types
class _G_mapState extends State<G_map> {
  final Completer<GoogleMapController> _controller = Completer();

  voidLocUpdate(List<Marker> marker) async {
    try {
      final curLoc = await Provider.of<LocationHandler>(context, listen: false)
          .getLocation();
      final markerlen = marker.length;
      print(markerlen);
      if (markerlen > 0) {
        final pos = mar[markerlen - 1].position;
        _camPossition = CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 15,
        );
      }
      if (oldLat != curLoc.latitude) {
        // load markericons
        await Provider.of<GoogleAPI>(context, listen: false).loadMarkerIcons();
        Provider.of<GoogleAPI>(context, listen: false).addMarker(curLoc);
        _camPossition = CameraPosition(
          target: LatLng(curLoc.latitude, curLoc.longitude),
          zoom: 16,
        );
        circles.add(Circle(
          circleId: const CircleId("currentLoc"),
          center: LatLng(curLoc.latitude, curLoc.longitude),
          radius: 100,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
        oldLat = curLoc.latitude;
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_camPossition));
      }

      // await Future.delayed(const Duration(seconds: 3));

      // delay for the map to load

    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(
        msg: "Oops! Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Map Style

  void setMapStyle(String mapStyle, GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = Provider.of<GoogleAPI>(context).getMarkers;

    voidLocUpdate(markers);
    mar = markers;
    return GoogleMap(
      zoomControlsEnabled: false,
      indoorViewEnabled: true,
      circles: circles.toSet(),
      mapType: MapType.normal,
      markers: markers.toSet(),
      onMapCreated: (GoogleMapController controller) {
        if (isFesh) {
          _controller.complete(controller);

          isFesh = false;
        }
        // changeMapMode(controller);
      },
      initialCameraPosition: _camPossition,
    );
  }
}
