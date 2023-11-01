import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/count_down.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_pin_code_field.dart';
import '../provider/auth_provider.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.fromRegister}) : super(key: key);
  final bool fromRegister;
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: context.toPadding + 180.h,
              width: context.width,
              padding: EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT.w,
                  right: Dimensions.PADDING_SIZE_DEFAULT.w,
                  top: context.toPadding,
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
                  const CustomAppBar(
                    fromAuth: true,
                    withPadding: false,
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    getTranslated("verify_header", context),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 24, color: Styles.WHITE_COLOR),
                  ),
                  Text(
                    getTranslated("verify_description", context),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 12, color: Styles.WHITE_COLOR),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Consumer<AuthProvider>(builder: (_, provider, child) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: context.toPadding + 160.h,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                      decoration: const BoxDecoration(
                          color: Styles.WHITE_COLOR,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: ListAnimator(
                        data: [
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT.h,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_LARGE.w),
                                        child: CustomPinCodeField(
                                            validation: Validations.code,
                                            controller: provider.codeTEC,
                                            onChanged: (v) {}),
                                      )),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  CountDown(
                                    onCount: () =>
                                        provider.resend(widget.fromRegister),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    child: CustomButton(
                                        text: getTranslated("submit", context),
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            CustomNavigator.push(
                                                Routes.RESET_PASSWORD);
                                            // provider
                                            //     .verify(widget.fromRegister);
                                          }
                                        },
                                        isLoading: provider.isVerify),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
