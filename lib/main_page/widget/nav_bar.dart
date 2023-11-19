import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/styles.dart';
import '../../app/core/utils/svg_images.dart';
import '../provider/main_page_provider.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Container(
          height: 80,
          width: context.width,
          decoration: BoxDecoration(color: Styles.WHITE_COLOR, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -3),
                spreadRadius: 3,
                blurRadius: 20)
          ]),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.homeIcon,
                    isSelected: provider.selectedIndex == 0,
                    onTap: () => provider.updateDashboardIndex(0),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.location,
                    isSelected: provider.selectedIndex == 1,
                    onTap: () => provider.updateDashboardIndex(1),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.notification,
                    isSelected: provider.selectedIndex == 2,
                    onTap: () => provider.updateDashboardIndex(2),
                  ),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.moreIcon,
                    isSelected: provider.selectedIndex == 3,
                    onTap: () => provider.updateDashboardIndex(3),
                  ),
                ),
              ]));
    });
  }
}
