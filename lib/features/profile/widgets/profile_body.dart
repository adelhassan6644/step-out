import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Container(
        margin:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.w),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        decoration: const BoxDecoration(
            color: Styles.WHITE_COLOR,
            border: Border(
                top: BorderSide(color: Styles.BORDER_COLOR),
                bottom: BorderSide(color: Styles.BORDER_COLOR))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customImageIconSVG(
                    imageName: SvgImages.userIcon, width: 24, height: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    getTranslated("personal_information", context),
                    style: AppTextStyles.medium.copyWith(
                        color: Styles.PRIMARY_COLOR,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(width: 16),
                customImageIconSVG(
                    imageName: SvgImages.edit,
                    onTap: () => CustomNavigator.push(Routes.EDIT_PROFILE)),
              ],
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated("name", context),
                    style: AppTextStyles.regular
                        .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                  ),

                  ///Phone
                  StreamBuilder<String?>(
                      stream: provider.nameStream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? snapshot.data ?? "Step Out"
                              : "Step Out",
                          style: AppTextStyles.medium
                              .copyWith(fontSize: 14, color: Styles.TITLE),
                        );
                      }),

                  Divider(
                    color: Styles.BORDER_COLOR,
                    height: 24.h,
                  ),
                  Text(
                    getTranslated("phone", context),
                    style: AppTextStyles.regular
                        .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                  ),

                  ///Phone
                  StreamBuilder<String?>(
                      stream: provider.phoneStream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData ? snapshot.data ?? "12345" : "12345",
                          style: AppTextStyles.medium
                              .copyWith(fontSize: 14, color: Styles.TITLE),
                        );
                      }),
                  Divider(
                    color: Styles.BORDER_COLOR,
                    height: 24.h,
                  ),
                  Text(
                    getTranslated("mail", context),
                    style: AppTextStyles.regular
                        .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                  ),
                  Text(
                    provider.profileModel?.email ?? "stepOut@gmail.com",
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.TITLE),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
