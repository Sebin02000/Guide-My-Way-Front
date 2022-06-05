import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/location.dart';

class GoogleAPI with ChangeNotifier {
  List<Marker> listMarker = [];
  List<String> markerID = [];
  List<BitmapDescriptor> markerImages = [];

// get markers
  List<Marker> get getMarkers {
    return listMarker;
  }

  Future<void> loadMarkerIcons() async {
    final currentLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 2.5,
        ),
        'asset/icon/dir.ico');
    markerImages.add(currentLocation);
  }

// get marker length
  int get getMarkerLength {
    return listMarker.length;
  }

// Add markers
  void addMarker(LocationModel loc) {
    // ignore: non_constant_identifier_names
    final String LocationID = loc.locationId == ""
        ? "${loc.latitude + loc.longitude}"
        : loc.locationId;

    if (loc.locationType == LocationType.currentLocation) {
      if (listMarker.isEmpty) {
        listMarker.add(Marker(
          icon: markerImages.isNotEmpty
              ? markerImages[0]
              : BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
        ));
      } else {
        listMarker[0] = Marker(
          icon: markerImages.isNotEmpty
              ? markerImages[0]
              : BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
        );
      }
    } else if (markerID.contains(LocationID)) {
      return;
    } else if (loc.locationType == LocationType.destination) {
      if (listMarker.length > 1) {
        listMarker[1] = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
        );
      } else if (loc.locationType == LocationType.origin) {
        listMarker.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
        ));
      } else {
        listMarker.add(Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
        ));
      }
    } else {
      listMarker.add(Marker(
          infoWindow: InfoWindow(title: loc.address),
          markerId: MarkerId(LocationID),
          position: LatLng(loc.latitude, loc.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow)));
    }
    notifyListeners();
  }

  // Remove markers
  void removeMarker(LocationModel loc) {
    final String locationID = loc.locationId == ""
        ? "${loc.latitude + loc.longitude}"
        : loc.locationId;
    if (!markerID.contains(locationID)) {
      return;
    }
    listMarker.removeWhere((element) => element.markerId.value == locationID);
    notifyListeners();
  }

  // remove all markers
  void removeAllMarkers() {
    listMarker.clear();
    notifyListeners();
  }

  // get directions
  Future<void> getDirections(LocationModel loc) async {
    final String locationID = loc.locationId == ""
        ? "${loc.latitude + loc.longitude}"
        : loc.locationId;
    if (markerID.contains(locationID)) {
      return;
    }
    markerID.add(locationID);
    notifyListeners();
  }

  // remove marker with locationtype
  void removeMarkerWithLocationType(LocationType type) {
    //  find marker with location type
    listMarker
        .removeWhere((element) => element.markerId.value == type.toString());
    notifyListeners();
  }
}
