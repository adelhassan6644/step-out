import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../app/core/utils/styles.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';

loadingDialog() {
  return showAnimatedDialog(
    context: CustomNavigator.navigatorState.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT.w,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        insetPadding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE.w,
            horizontal: context.width * 0.2),
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20.0)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            Images.logo,
            height: MediaQuery.of(context).size.width * .25,
            width: MediaQuery.of(context).size.width * .25,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            child: Text(
              getTranslated("loading", context),
              style: AppTextStyles.bold.copyWith(
                fontSize: 16.0,
                color: Styles.PRIMARY_COLOR,
              ),
            ),
          ),
        ]),
      );
    },
    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.easeInOutBack,
    duration: const Duration(milliseconds: 700),
  );
}

spinKitDialog() {
  showDialog(
      barrierDismissible: false,
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (BuildContext context) {
        return SizedBox(
          height: context.height,
          width: context.width,
          child: const Center(
            child: Center(
              child: SpinKitFadingCircle(
                color: Styles.WHITE_COLOR,
                size: 50,
              ),
            ),
          ),
        );
      });
}
