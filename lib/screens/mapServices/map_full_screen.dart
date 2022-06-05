import 'package:flutter/material.dart';

import 'g_map.dart';
import '../../widgets/place_search.dart';

class MapFullScreen extends StatelessWidget {
  const MapFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size of the screen
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const G_map(),
          // container with bottom corner rounded
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(30),
          //       bottomRight: Radius.circular(30),
          //     ),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          //       // container with grey background
          //       InkWell(
          //         onTap: () => Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (builder) => const LocationSelectSreen())),
          //         child: Container(
          //           height: 50,
          //           width: MediaQuery.of(context).size.width - 30,
          //           color: Colors.grey,
          //           child: const Center(
          //             child: Text(
          //               'Select Location',
          //               style: TextStyle(
          //                 fontSize: 25,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              // title: const Text(
              //   'Where to go?',
              //   style: TextStyle(
              //     color: Colors.black,
              //   ),
              // ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // Align(
          //     alignment: Alignment(0, -size.height * 0.001),
          //     child: const PlaceSearch())
        ],
      ),
    );
  }
}
