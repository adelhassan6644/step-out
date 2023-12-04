import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_images.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../widgets/login_body_widget.dart';

class Login extends StatelessWidget {
  final bool fromMain;
  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: context.toPadding + 180.h,
            width: context.width,
            padding: EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT.w,
                right: Dimensions.PADDING_SIZE_DEFAULT.w,
                top: fromMain
                    ? context.toPadding
                    : (context.toPadding + Dimensions.PADDING_SIZE_DEFAULT.h),
                bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(Images.authBG),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (fromMain)
                  const CustomAppBar(
                    withHPadding: false,
                    withSafeArea: false,
                    backColor: Styles.WHITE_COLOR,
                  ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Text(
                      getTranslated("login_header", context),
                      textAlign: TextAlign.start,
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 24, color: Styles.WHITE_COLOR),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    customImageIconSVG(imageName: SvgImages.checkHand)
                  ],
                ),
                Text(
                  getTranslated("login_description", context),
                  textAlign: TextAlign.start,
                  style: AppTextStyles.medium
                      .copyWith(fontSize: 14, color: Styles.WHITE_COLOR),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                ),
              ],
            ),
          ),
          const Column(
            children: [
              Expanded(child: LoginBodyWidget()),
            ],
          ),
        ],
      ),
    );
  }
}
