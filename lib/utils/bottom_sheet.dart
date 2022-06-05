import 'package:flutter/material.dart';

// show model bottom sheet widget
void showModelBottomSheet(BuildContext context, String text,
    {isDismis = false}) {
  showModalBottomSheet(
    isDismissible: isDismis,
    // top rounded corner
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isDismis)
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Dismiss'),
                ),
              ),
          ],
        ),
      );
    },
  );
}
