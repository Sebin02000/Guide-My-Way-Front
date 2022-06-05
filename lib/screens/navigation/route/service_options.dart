import 'package:flutter/material.dart';
import 'package:maps_app/models/location.dart';
import 'package:maps_app/models/services.dart';
import 'package:maps_app/provider/location/location_services.dart';
import 'package:provider/provider.dart';

class ServiceOptions extends StatelessWidget {
  const ServiceOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<LocationModel> wayPoints =
        Provider.of<LocationHandler>(context).wayPointsList;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            deleteIcon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onDeleted: () {
              Provider.of<LocationHandler>(context, listen: false)
                  .removeWayPoint(wayPoints[i]);
            },
            label: Text(wayPoints[i].address.trim()),
          ),
        ),
        itemCount: wayPoints.length,
      ),
    );
  }
}
