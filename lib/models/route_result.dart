import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteResult {
  String? summary;
  Bound? bound;
  List<Legs>? legs;
  OverviewPolyline? overviewPolyline;
  List<String>? instructions;

  RouteResult(
      {this.summary,
      this.bound,
      this.legs,
      this.overviewPolyline,
      this.instructions});

  RouteResult.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    bound = json['bound'] != null ?  Bound.fromJson(json['bound']) : null;
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add( Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ?  OverviewPolyline.fromJson(json['overview_polyline'])
        : null;
    instructions = json['instructions'].cast<String>();
  }


}

class Bound {
  Northeast? northeast;
  Northeast? southwest;

  Bound({this.northeast, this.southwest});

  Bound.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ?  Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ?  Northeast.fromJson(json['southwest'])
        : null;
  }

 
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

 
}

class Legs {
  String? duration;
  String? distance;
  List<Steps>? steps;
  String? startAddress;
  String? endAddress;
  Northeast? startLocation;
  Northeast? endLocation;

  Legs(
      {this.duration,
      this.distance,
      this.steps,
      this.startAddress,
      this.endAddress,
      this.startLocation,
      this.endLocation});

  Legs.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    distance = json['distance'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add( Steps.fromJson(v));
      });
    }
    startAddress = json['start_address'];
    endAddress = json['end_address'];
    startLocation = json['start_location'] != null
        ?  Northeast.fromJson(json['start_location'])
        : null;
    endLocation = json['end_location'] != null
        ?  Northeast.fromJson(json['end_location'])
        : null;
  }

 
}

class Steps {
  String? instruction;
  String? maneuver;
  String? distance;
  String? duration;
  Northeast? startLocation;
  Northeast? endLocation;

  Steps(
      {this.instruction,
      this.maneuver,
      this.distance,
      this.duration,
      this.startLocation,
      this.endLocation});

  Steps.fromJson(Map<String, dynamic> json) {
    instruction = json['instruction'];
    maneuver = json['maneuver'];
    distance = json['distance'];
    duration = json['duration'];
    startLocation = json['start_location'] != null
        ?  Northeast.fromJson(json['start_location'])
        : null;
    endLocation = json['end_location'] != null
        ?  Northeast.fromJson(json['end_location'])
        : null;
  }

  
}



class OverviewPolyline {
  List<Polyline> points = [];

  OverviewPolyline({required this.points});

  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    final pol = json['points'];
    print(pol);
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    final List<PointLatLng> polPoints = polylinePoints.decodePolyline(pol);
    polPoints.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    points.add(Polyline(
      polylineId: const PolylineId("poly"),
      color: Colors.green,
      points: polylineCoordinates,
    ));
  }
}
