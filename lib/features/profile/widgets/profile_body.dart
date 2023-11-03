import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

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
          children: [
            Row(
              children: [
                customImageIconSVG(imageName: SvgImages.userIcon),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    getTranslated("personal_information", context),
                    style: AppTextStyles.medium.copyWith(
                        color: Styles.PRIMARY_COLOR,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(width: 16.w),
                customImageIconSVG(imageName: SvgImages.edit),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    });
  }
}
