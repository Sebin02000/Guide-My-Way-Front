import 'package:flutter/material.dart';
import 'package:maps_app/provider/location/location_services.dart';
import 'package:provider/provider.dart';

import '../../utils/apptheme.dart';

class TravelModeOption extends StatelessWidget {
  const TravelModeOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ThemeConfig.greyBg,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Travel Mode",
                style: ThemeConfig.textTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // rounded container
                Modeoptions(
                  icon: Icons.directions_car,
                  title: "Car",
                  val: "driving",
                ),
                Modeoptions(
                  icon: Icons.pedal_bike,
                  title: "Bike",
                  val: "bicycling",
                ),
                Modeoptions(
                  icon: Icons.directions_walk,
                  title: "Walk",
                  val: "walking",
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class Modeoptions extends StatelessWidget {
  const Modeoptions({
    Key? key,
    required this.title,
    required this.icon,
    required this.val,
  }) : super(key: key);
  final String title;
  final IconData icon;

  final String val;
  @override
  Widget build(BuildContext context) {
    final mod = Provider.of<LocationHandler>(
      context,
    ).getMode;
    final bool isSelected = mod == val;
    return InkWell(
      onTap: () {
        Provider.of<LocationHandler>(context, listen: false).changeMode(val);
      },
      child: Container(
        width: 80,
        height: 130,
        decoration: BoxDecoration(
          color: isSelected ? ThemeConfig.viloteDark : Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 30,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              title,
              style: ThemeConfig.textTheme.subtitle1!
                  .copyWith(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
