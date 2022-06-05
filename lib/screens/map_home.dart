import 'package:flutter/material.dart';
import '../widgets/Home/main_option.dart';
import '../widgets/Home/travel_options.dart';
import 'mapServices/g_map.dart';

class MapHome extends StatelessWidget {
  const MapHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // sieze of screen
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        height: size.height * 0.40,
        child: const G_map(),
      ),
      // top rounded container
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  height: 10,
                  width: 30,
                ),
                const MainOption(),
                const SizedBox(
                  height: 10,
                ),
                const TravelModeOption(),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
