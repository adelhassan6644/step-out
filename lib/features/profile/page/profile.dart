import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/features/profile/widgets/profile_image_widget.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../more/widgets/more_button.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("profile", context),
      ),
      body: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return Column(
          children: [
            Expanded(
                child: ListAnimator(
              data: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: 40.h),
                  child: const ProfileImageWidget(
                    withEdit: true,
                    radius: 60,
                  ),
                ),
                const ProfileBody(),
                SizedBox(height: 24.h),
                MoreButton(
                  title: getTranslated("change_password", context),
                  icon: SvgImages.lockIcon,
                  onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
                ),
                MoreButton(
                  title: getTranslated("remove_acc", context),
                  icon: SvgImages.trash,
                  withBottomBorder: true,
                  // onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
                ),
              ],
            ))
          ],
        );
      }),
    );
  }
}
