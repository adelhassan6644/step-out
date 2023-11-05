import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../profile/widgets/profile_image_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          ///Profile Date
          Container(
            margin: EdgeInsets.only(
                top: 40,
                bottom: 40,
                right: Dimensions.PADDING_SIZE_DEFAULT.w,
                left: Dimensions.PADDING_SIZE_DEFAULT.w),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            height: 120,
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    spreadRadius: 4,
                    blurRadius: 5)
              ],
              image: const DecorationImage(
                image: ExactAssetImage(Images.authBG),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Text(
                  provider.isLogin
                      ? provider.profileModel?.name ?? ""
                      : "Guest",
                  style: AppTextStyles.bold.copyWith(
                      color: Styles.SPLASH_BACKGROUND_COLOR,
                      fontSize: 16,
                      height: 1),
                ),
                SizedBox(height: 8.h),
                Text(
                  provider.isLogin
                      ? provider.profileModel?.email ?? ""
                      : "guest@stepOut.com",
                  style: AppTextStyles.regular.copyWith(
                      color: Styles.SPLASH_BACKGROUND_COLOR, fontSize: 12),
                ),
              ],
            ),
          ),

          ///Profile Image
          const Center(
            child: ProfileImageWidget(
              withEdit: false,
              radius: 40,
            ),
          ),
        ],
      );
    });
  }
}
