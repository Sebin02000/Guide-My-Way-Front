import 'package:flutter/material.dart';

import '../../../widgets/place_search.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/location-search';
  final bool isServices;
  final bool akshya;
  const SearchScreen({this.isServices = false, this.akshya = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlaceSearch(isServices, akshya),
    );
  }
}
