import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/route_result.dart';
import 'package:maps_app/provider/location/google.dart';
import 'package:provider/provider.dart';

import '../../provider/location/location_services.dart';

class GmapPolyLines extends StatefulWidget {
  static const String routeName = '/gmap-polylines';
  const GmapPolyLines({Key? key}) : super(key: key);

  @override
  State<GmapPolyLines> createState() => _GmapPolyLinesState();
}

final Completer<GoogleMapController> _controller = Completer();
bool fesh = false;

class _GmapPolyLinesState extends State<GmapPolyLines> {
  getPoints() {}
  @override
  Widget build(BuildContext context) {
    final polyLines = Provider.of<LocationHandler>(context).routeResult;
    final orgin = Provider.of<LocationHandler>(context).originLocation;
    // markers
    final markers = Provider.of<GoogleAPI>(context).getMarkers;

    final _camPossition = CameraPosition(
      target: LatLng(
        orgin.latitude,
        orgin.longitude,
      ),
      zoom: 10,
    );
    final bounds = polyLines.bound!;
    // size of screen
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(polyLines.summary!,
              style: const TextStyle(color: Colors.black)),
        ),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    height: size.height * 0.55,
                    child: mapShow(markers, polyLines, _camPossition))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                // roundedRectangle
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                height: size.height * 0.40,
                child: ListView.builder(
                  itemCount: polyLines.instructions!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.directions,
                          color: Colors.green,
                          size: 30,
                        ),
                        tileColor: Colors.white,
                        title: Text(polyLines.instructions![index]),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  GoogleMap mapShow(List<Marker> markers, RouteResult polyLines,
      CameraPosition _camPossition) {
    return GoogleMap(
        markers: markers.toSet(),
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          if (!fesh) {
            _controller.complete(controller);
            fesh = true;
          }
        },
        polylines: Set<Polyline>.of(polyLines.overviewPolyline!.points),
        // cameraTargetBounds: CameraTargetBounds(
        //   LatLngBounds(
        //     northeast: LatLng(bounds.northeast!.lat!, bounds.northeast!.lng!),
        //     southwest: LatLng(bounds.southwest!.lat!, bounds.southwest!.lng!),
        //   ),
        // ),
        initialCameraPosition: _camPossition);
  }
}
