// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../models/location.dart';
import '../../models/places_search.dart';
import '../../models/route_result.dart';
import '../../models/services.dart';
import '../../utils/apiServices.dart';

class LocationHandler with ChangeNotifier {
  // ignore: non_constant_identifier_names
  static String API = GOOGLE_API;
  static String serverUrl = URL_BASE;
  String mode = "driving";

  // get current location
  LocationModel _locationModel = LocationModel(
    latitude: 0.0,
    longitude: 0.0,
    address: '',
  );
  LocationModel _origin = LocationModel(
    latitude: 0.0,
    longitude: 0.0,
    address: '',
  );
  LocationModel _destintaionLoca = LocationModel(
    latitude: 0.0,
    longitude: 0.0,
    address: '',
  );
  List<LocationModel> wayPoints = [];
  RouteResult _routeResult = RouteResult();
  Future<LocationModel> getLocation() async {
    try {
      // Permission handler

      await Permission.location.request();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: 'en_US');
      _locationModel = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          address: placemarks[0].locality!,
          rotaion: position.heading,
          locationType: LocationType.currentLocation);
      if (_origin.latitude == 0.0 && _origin.longitude == 0.0) {
        _origin = _locationModel;
      }

      notifyListeners();
      return _locationModel;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  // akshya direction
  Future<RouteResult> getAkshyaDirection(LocationModel loc) async {
    try {
      // ignore: unused_local_variable
      _destintaionLoca = loc;
      // ignore: list_remove_unrelated_type
      return await getDirection();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

// get mode
  String get getMode => mode;

// change mode
  void changeMode(String modes) {
    mode = modes;
    notifyListeners();
  }

  // Places Search
  List<PlacesSearch> _placesSearch = [];
  // get waypoints
  List<LocationModel> get wayPointsList => wayPoints;

  Future<List<PlacesSearch>> placeSearch(String keyword) async {
    try {
      final Uri url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$keyword&location=${_locationModel.latitude},${_locationModel.longitude}&radius=100000&strictbounds=true&key=$API');
      debugPrint(url.toString());
      final http.Response response = await http.get(url);
      final data = json.decode(response.body);
      _placesSearch = placeSearchFromJson(data);

      return _placesSearch;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  // get destination location
  LocationModel get destinationLocation => _destintaionLoca;
  //  get origin location
  LocationModel get originLocation => _origin;

  // set destination
  // get place Detail
  Future<LocationModel> getPlaceDetail(String placeId) async {
    try {
      final Uri url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$API');
      final http.Response response = await http.get(url);

      final data = json.decode(response.body);
      final placeDetail = locationModelFromPlaceSearch(data['results'][0]);

      notifyListeners();
      return placeDetail;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<LocationModel> setDesOrigin(LocationModel location,
      {bool isOrigin = false}) async {
    try {
      if (isOrigin) {
        _origin = location;
      } else {
        _destintaionLoca = location;
      }

      notifyListeners();
      return _destintaionLoca;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

// get _routeResult
  RouteResult get routeResult => _routeResult;

  Future<RouteResult> getDirection() async {
    try {
      // check destination and origin lat and long not null
      if (checkDestination()) {
        final Uri url = wayPoints.isNotEmpty
            ? Uri.parse("$serverUrl/serviceroute/")
            : Uri.parse("$serverUrl/route/");
        String wapStr = "";
        if (wayPoints.isNotEmpty) {
          for (var element in wayPoints) {
            wapStr += "|${element.latitude},${element.longitude}";
          }
        }
        final http.Response response = await http.post(url, body: {
          "origin": "${_origin.latitude},${_origin.longitude}",
          "destination":
              "${_destintaionLoca.latitude},${_destintaionLoca.longitude}",
          "mode": mode,
          "services": wapStr.toString()
        });
        final data = json.decode(response.body);

        _routeResult = RouteResult.fromJson(data["data"]);
        print(_routeResult.overviewPolyline!.points);
        notifyListeners();
        return _routeResult;
      } else {
        throw "Destination not set";
      }
      // https://maps.googleapis.com/maps/api/geocode/json?latlng=lat,lng&key=YOUR_API_KEY

    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

// add way point
  void addWayPoint(LocationModel locationModel) {
    if (_destintaionLoca.latitude == 0) {
      _destintaionLoca = locationModel;
    } else {
      wayPoints.add(locationModel);
    }
    notifyListeners();
  }

  // remove way point
  void removeWayPoint(LocationModel locationModel) {
    wayPoints.remove(locationModel);
    notifyListeners();
  }

  // change mode

  bool checkDestination() {
    if (_destintaionLoca.latitude == 0.0 ||
        _destintaionLoca.longitude == 0.0 ||
        _origin.latitude == 0.0 ||
        _origin.longitude == 0.0) {
      return false;
    } else {
      return true;
    }
  }

  // ge nearby places
  Future<ServicesResult> getServices(String key) async {
    try {
      ServicesResult _servicesResult = ServicesResult();
      final Uri url = Uri.parse("$serverUrl/services/");
      final http.Response response = await http.post(url, body: {
        "location": "${_origin.latitude},${_origin.longitude}",
        "keyword": key
      });
      final data = json.decode(response.body);

      _servicesResult = ServicesResult.fromJson(data);
      notifyListeners();
      return _servicesResult;
      // https://maps.googleapis.com/maps/api/geocode/json?latlng=lat,lng&key=YOUR_API_KEY

    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  // clear all
  void clearAll() {
    _routeResult = RouteResult();
    notifyListeners();
  }

  // login
}

// check  destination and origin lat and long not zero
