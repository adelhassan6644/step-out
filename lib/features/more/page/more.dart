import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/features/more/widgets/logout_button.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../widgets/more_button.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
            Dimensions.PADDING_SIZE_DEFAULT,
            (Dimensions.PADDING_SIZE_DEFAULT + context.toPadding),
            Dimensions.PADDING_SIZE_DEFAULT,
            Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            const ProfileCard(),
            MoreButton(
              title: getTranslated("dashboard", context),
              icon: SvgImages.homeIcon,
              onTap: () {
                provider.updateDashboardIndex(0);
              },
            ),
            MoreButton(
              title: getTranslated("profile", context),
              icon: SvgImages.userIcon,
              onTap: () {
                provider.updateDashboardIndex(1);
              },
            ),
            MoreButton(
              title: getTranslated("favourites", context),
              icon: SvgImages.heartIcon,
              onTap: () {
                provider.updateDashboardIndex(3);
              },
            ),
            MoreButton(
              title: getTranslated("contact_with_us", context),
              icon: SvgImages.mailIcon,
              onTap: () {},
            ),
            MoreButton(
              title: getTranslated("terms_conditions", context),
              icon: SvgImages.file,
              onTap: () {
                CustomNavigator.push(Routes.TERMS);
              },
            ),
            MoreButton(
              title: getTranslated("about_us", context),
              icon: SvgImages.aboutUsIcon,
              onTap: () {
                CustomNavigator.push(Routes.ABOUT_US);
              },
            ),
            const Expanded(child: SizedBox()),
            LogoutButton(
              onTap: () {
                provider.updateDashboardIndex(0);
              },
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }
}
