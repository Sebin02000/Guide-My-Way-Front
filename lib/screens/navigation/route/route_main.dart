import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_app/screens/mapServices/g_map.dart';

import '../search/route_buttons.dart';
import 'locations_selction.dart';
import 'service_options.dart';

class RouteMain extends StatelessWidget {
  static const String routeName = '/route-main';
  const RouteMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // size of the screen
    final size = MediaQuery.of(context).size;
    final DateTime date = DateTime.now();
    return Scaffold(
        body: Stack(
      children: [
        // back button

        SizedBox(height: size.height * 0.55, child: const G_map()),
        backButton(size, context),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: size.height * 0.5,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // sample date in the format of "Monday, May 1"
                        DateFormat('yMMMMd').format(date),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '🕣 ${DateFormat('jm').format(date)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Rounded container with border color
                  const LocationSelction(),
                  const SizedBox(height: 15),
                  // Chip(label: Text("vgd"))
                  // horizontal scrollable listview builder
                  const ServiceOptions(),
                  const Spacer(),
                  //  Row of two text icon buttons
                  const ButtonsRoute(),
                  const SizedBox(height: 15),
                ],
              ),
            ))
      ],
    ));
  }

  Positioned backButton(Size size, BuildContext context) {
    return Positioned(
      top: size.height * 0.05,
      left: size.width * 0.05,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
