import 'package:flutter/material.dart';
import 'package:maps_app/provider/location/location_services.dart';
import 'package:maps_app/utils/bottom_sheet.dart';
import 'package:provider/provider.dart';

class ButtonsRoute extends StatelessWidget {
  const ButtonsRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //  Rounded Textbuttonicon
        iconButton(context, Icons.add_box_outlined, 'Add Services', false),
        iconButton(context, Icons.directions, 'Get Directions', true),
      ],
    );
  }
}

Widget iconButton(
    BuildContext ctx, IconData iconData, String text, bool isDirections) {
  return TextButton.icon(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            !isDirections ? Colors.white : Colors.green),
        foregroundColor: MaterialStateProperty.all<Color>(
            isDirections ? Colors.white : Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.green)))),
    icon: Icon(iconData),
    label: Text(text),
    onPressed: () async {
      if (!isDirections) {
        await Navigator.pushNamed(ctx, '/addServices');
      } else {
        showModelBottomSheet(ctx, "Please wait...");
        await Provider.of<LocationHandler>(ctx, listen: false).getDirection();
        Navigator.pop(ctx);
        Navigator.of(ctx).pushNamed("/gmap-polylines");
      }
    },
  );
}
