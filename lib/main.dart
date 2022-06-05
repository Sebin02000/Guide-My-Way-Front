import 'package:flutter/material.dart';
import 'package:maps_app/screens/login.dart';
import 'package:maps_app/utils/apptheme.dart';
import 'package:provider/provider.dart';

import 'provider/location/google.dart';
import 'provider/location/location_services.dart';
import 'screens/documents/document.dart';
import 'screens/mapServices/g_map_poly_lines.dart';
import 'screens/map_home.dart';
import 'screens/navigation/route/route_main.dart';
import 'screens/navigation/search/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationHandler()),
        ChangeNotifierProvider(create: (context) => GoogleAPI()),
      ],
      child: MaterialApp(
        title: 'Maps',
        theme: ThemeConfig.lightTheme,
        scrollBehavior: MyBehavior(),
       
        routes: {
          "/": (context) => LoginScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RouteMain.routeName: (context) => const RouteMain(),
          GmapPolyLines.routeName: (context) => const GmapPolyLines(),
          "/addServices": (context) => const SearchScreen(
                isServices: true,
              ),
          "document": (context) => const DocumentScreen(),
        },
      ),
    );
  }
}
