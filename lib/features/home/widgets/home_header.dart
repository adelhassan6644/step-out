import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../components/custom_images.dart';
import '../../../main_page/provider/main_page_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.toPadding + Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
        right: Dimensions.PADDING_SIZE_DEFAULT.w,
        left: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
              onTap: () => CustomNavigator.push(Routes.SEARCH),
              imageName: SvgImages.search,
              width: 24,
              height: 24),
          const Expanded(child: SizedBox()),
          customImageIcon(imageName: Images.homeLogo, width: 100),
          const Expanded(child: SizedBox()),
          Consumer<MainPageProvider>(builder: (_, provider, child) {
            return customImageIconSVG(
                onTap: () => provider.updateDashboardIndex(2),
                imageName: SvgImages.notification,
                width: 24,
                height: 24);
          }),
        ],
      ),
    );
  }
}
