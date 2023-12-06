import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../app/localization/language_constant.dart';
import '../../components/custom_button.dart';
import '../../components/custom_images.dart';

class GuestMode extends StatelessWidget {
  const GuestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        customPadding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        data: [
          SizedBox(
            height: context.height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.25),
            child: customImageIcon(
              imageName: Images.logo,
              height: context.height * 0.2,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            getTranslated("register_with_us", context),
            style: AppTextStyles.bold.copyWith(
              fontSize: 32,
              color: Styles.PRIMARY_COLOR,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            getTranslated(
                "and_enjoy_all_the_features_available_in_the_application",
                context),
            style: AppTextStyles.medium
                .copyWith(fontSize: 18, color: Styles.ACCENT_COLOR),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CustomButton(
              text: getTranslated("login", context),
              onTap: () => CustomNavigator.push(Routes.LOGIN, arguments: true),
            ),
          ),
        ],
      ),
    );
  }
}
