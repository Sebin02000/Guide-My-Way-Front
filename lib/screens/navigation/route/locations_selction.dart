import 'package:flutter/material.dart';
import 'package:maps_app/models/location.dart';
import 'package:maps_app/provider/location/google.dart';
import 'package:provider/provider.dart';
import '../../../provider/location/location_services.dart';
import '../../../utils/apptheme.dart';
import '../../../utils/bottom_sheet.dart';

class LocationSelction extends StatelessWidget {
  const LocationSelction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationModel origin = Provider.of<LocationHandler>(context).originLocation;
    LocationModel destination =
        Provider.of<LocationHandler>(context).destinationLocation;
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LocationFeild(false, origin),
          // dashed line
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          LocationFeild(true, destination),
        ],
      ),
    );
  }
}

class LocationFeild extends StatelessWidget {
  const LocationFeild(
    this.isDestination,
    this.locationModel, {
    Key? key,
  }) : super(key: key);
  final bool isDestination;
  final LocationModel locationModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final LocationModel? place = await Navigator.of(context)
              .pushNamed("/location-search") as LocationModel;
          if (place != null) {
            if (isDestination) {
              place.locationType = LocationType.destination;
              Provider.of<GoogleAPI>(context, listen: false).addMarker(place);

              Provider.of<LocationHandler>(context, listen: false)
                  .setDesOrigin(place);
            } else {
              place.locationType = LocationType.origin;
              Provider.of<GoogleAPI>(context, listen: false).addMarker(place);
              Provider.of<LocationHandler>(context, listen: false)
                  .setDesOrigin(place, isOrigin: true);
            }
          }
        } catch (e) {
          print(e);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: Icon(
                  isDestination
                      ? Icons.location_on_outlined
                      : Icons.location_history,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationModel.address.length > 30
                      ? '${locationModel.address.substring(0, 30)}...'
                      : locationModel.address,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeConfig.textTheme.headline3,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  locationModel.address.length > 40
                      ? '${locationModel.address.substring(0, 40)}...'
                      : locationModel.address,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeConfig.textTheme.subtitle2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
