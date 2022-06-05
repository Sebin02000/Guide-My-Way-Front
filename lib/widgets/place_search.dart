import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_app/models/services.dart';
import 'package:maps_app/provider/location/google.dart';
import 'package:maps_app/utils/apptheme.dart';
import 'package:provider/provider.dart';

import '../models/location.dart';
import '../models/places_search.dart';
import '../provider/location/location_services.dart';
import '../utils/bottom_sheet.dart';

class PlaceSearch extends StatefulWidget {
  const PlaceSearch(this.isService, this.akshya, {Key? key}) : super(key: key);
  final bool isService;
  final bool akshya;

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

TextEditingController _searchController = TextEditingController();
List<PlacesSearch> _searchResults = [];
ServicesResult _serviceResult = ServicesResult();
bool isAkLoded = false;
bool loding = false;

class _PlaceSearchState extends State<PlaceSearch> {
  search(e) async {
    try {
      Fluttertoast.showToast(
        msg: "Please wait...",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
      setState(() {
        loding = true;
      });
      if (!widget.isService) {
        final re = await Provider.of<LocationHandler>(context, listen: false)
            .placeSearch(e);
        _searchResults = re;
      } else {
        _serviceResult =
            await Provider.of<LocationHandler>(context, listen: false)
                .getServices(e);
      }
      // close showModelBottomSheet
      setState(() {
        isAkLoded = true;
        loding = false;
      });
    } catch (e) {
      setState(() {
        loding = false;
      });
      Fluttertoast.showToast(
        msg: "Oops! Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  addToMarker(String id) async {
    try {
      // show model bottom sheet
      showModelBottomSheet(context, "Please wait...");

      final LocationModel re =
          await Provider.of<LocationHandler>(context, listen: false)
              .getPlaceDetail(id);
      Navigator.pop(context);
      _searchResults = [];
      _searchController.text = "";
      Navigator.of(context).pop(re);
    } catch (e) {
      Navigator.pop(context);

      // Fluttertoast.showToast(
      //   msg: "Oops! Something went wrong",
      //   toastLength: Toast.LENGTH_SHORT,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
  }

  @override
  void dispose() {
    _searchResults = [];
    _serviceResult = ServicesResult();
    _searchController.clear();
    isAkLoded = false;
    loding = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size of screen
    final Size size = MediaQuery.of(context).size;
    if (widget.akshya && !isAkLoded) {
      search("Akshya center");
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: SizedBox(
        height: size.height - 30,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onSubmitted: search,
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  // edge insets
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // places list
            if (loding)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (_searchResults.isNotEmpty && !widget.isService && !loding)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    // edge insets
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 20, horizontal: 20),
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => addToMarker(_searchResults[index].id),
                        key: Key(_searchResults[index].id),
                        leading: const Icon(Icons.location_on),
                        title: Text(_searchResults[index].name),
                      );
                    },
                  ),
                ),
              ),
            if (_serviceResult.data != null && !loding)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    // edge insets
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 20, horizontal: 20),
                    shrinkWrap: true,
                    itemCount: _serviceResult.data!.length,
                    itemBuilder: (context, index) {
                      final Data data = _serviceResult.data![index];
                      return ListTile(
                        onTap: () async {
                          LocationModel loc = LocationModel(
                            address: data.name!,
                            latitude: data.loaction!.lat!,
                            longitude: data.loaction!.lng!,
                            locationType: LocationType.intermediate,
                          );
                          if (!widget.akshya) {
                            Provider.of<LocationHandler>(context, listen: false)
                                .addWayPoint(loc);
                            Provider.of<GoogleAPI>(context, listen: false)
                                .addMarker(loc);

                            return Navigator.pop(context);
                          }
                          Fluttertoast.showToast(
                            msg: "Please wait...",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                          loc.locationType = LocationType.destination;
                          Provider.of<GoogleAPI>(context, listen: false)
                              .addMarker(loc);
                          await Provider.of<LocationHandler>(context,
                                  listen: false)
                              .getAkshyaDirection(loc);
                          Navigator.of(context).pushNamed("/gmap-polylines");
                        },
                        key: Key(data.name!),
                        leading: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.network(data.iconUrl!)),
                        title: Text(data.name!),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              child: Text(
                                "${data.rating!}",
                                style: ThemeConfig.textTheme.headline3,
                              ),
                            ),
                            Text(
                              "(${data.noOfRating!})",
                              style: ThemeConfig.textTheme.headline1?.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                            data.description ?? "No description available"),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
