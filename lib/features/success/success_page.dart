import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../app/core/utils/styles.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/language_constant.dart';
import '../../components/custom_button.dart';
import '../../components/custom_images.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import 'model/success_model.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({required this.successModel, super.key});
  final SuccessModel successModel;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late Timer _timer;
  int _count = 0;
  @override
  void initState() {
    countDown();
    super.initState();
  }

  countDown() {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (_count != 0) {
          --_count;
        } else {
          CustomNavigator.push(Routes.DASHBOARD, clean: true);

          if (_timer.isActive) _timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => !widget.successModel.isPopUp,
        child: Container(
          height: context.height,
          width: context.width,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: Styles.kBackgroundGradient,
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: customImageIcon(
                    imageName: Images.success, width: 150, height: 150),
              ),

              SizedBox(height: 40.h),

              ///Title
              Visibility(
                visible: widget.successModel.title != null,
                child: Text(
                  widget.successModel.title ?? "",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 28, color: Styles.WHITE_COLOR),
                ),
              ),

              ///Description
              Visibility(
                visible: widget.successModel.description != null,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: SubstringHighlight(
                      textAlign: TextAlign.center,
                      text: widget.successModel.description ?? "",
                      term: widget.successModel.term ?? "",
                      textStyle: AppTextStyles.regular.copyWith(
                          fontSize: 16, color: const Color(0xFFE1A6ED)),
                      textStyleHighlight: AppTextStyles.semiBold
                          .copyWith(fontSize: 16, color: Styles.WHITE_COLOR),
                    ),
                  ),
                ),
              ),

              ///Buttons
              Visibility(
                visible: !widget.successModel.isPopUp,
                child: Column(
                  children: [
                    CustomButton(
                      text: widget.successModel.btnText ??
                          getTranslated("confirm", context),
                      onTap: widget.successModel.onTap?.call(),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomButton(
                      onTap: () {
                        CustomNavigator.push(Routes.DASHBOARD,
                            arguments: 0, clean: true);
                      },
                      text: getTranslated("close", context),
                      backgroundColor: Styles.WHITE_COLOR,
                      withBorderColor: true,
                      textColor: Styles.PRIMARY_COLOR,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
