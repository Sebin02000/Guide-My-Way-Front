import 'package:flutter/material.dart';

import '../../screens/navigation/search/search_screen.dart';
import '../../utils/apptheme.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.width,
    this.height = 220,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.onTap,
    this.colorIcon = Colors.white,
    required this.backgroundColorIcon,
  }) : super(key: key);
  final double width;
  final double height;
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final String onTap;
  final Color colorIcon;
  final Color backgroundColorIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        if (onTap == "akshya") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const SearchScreen(
                    isServices: true,
                    akshya: true,
                  )));
        } else {
          Navigator.of(context).pushNamed(onTap);
        }
      }),
      child: Container(
        height: height,
        width: width,
        // Rounded corner container
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (title != "") const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: title != "" ? 15 : 0),
              child: Align(
                  alignment: title != "" ? Alignment.topLeft : Alignment.center,
                  child: CircleAvatar(
                      radius: 23,
                      backgroundColor: backgroundColorIcon,
                      child: Icon(
                        icon,
                        color: colorIcon,
                        size: 30,
                      ))),
            ),
            if (title != "")
              const SizedBox(
                height: 10,
              ),
            if (title != "")
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15),
                child: Text(title,
                    style: ThemeConfig.textTheme.headline5!.copyWith(
                      color: textColor,
                    )),
              ),
            if (title != "") const Spacer(),
          ],
        ),
      ),
    );
  }
}
