import 'package:flutter/material.dart';
import 'package:maps_app/widgets/Home/cards.dart';

import '../../utils/apptheme.dart';

class MainOption extends StatelessWidget {
  const MainOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const OptionCard(
          title: "Get Me Somewhere",
          icon: Icons.search,
          width: 150,
          backgroundColor: ThemeConfig.greenLite,
          backgroundColorIcon: ThemeConfig.greenDark,
          onTap: '/route-main',
        ),
        const OptionCard(
            title: "Get Me home",
            icon: Icons.home_outlined,
            width: 110,
            backgroundColor: ThemeConfig.pinkLite,
            backgroundColorIcon: ThemeConfig.redBg,
            onTap: "/"),
        Column(
          children: const [
            OptionCard(
              title: "",
              icon: Icons.star_border,
              width: 90,
              height: 105,
              backgroundColor: ThemeConfig.greyBg,
              backgroundColorIcon: ThemeConfig.greyBg,
              colorIcon: Colors.black,
              onTap: "akshya",
            ),
            SizedBox(
              height: 10,
            ),
            OptionCard(
                title: "",
                icon: Icons.cases_outlined,
                width: 90,
                height: 105,
                backgroundColor: ThemeConfig.yellow,
                backgroundColorIcon: ThemeConfig.yellow,
                colorIcon: Colors.black,
                onTap: "document"),
          ],
        ),
      ],
    );
  }
}
