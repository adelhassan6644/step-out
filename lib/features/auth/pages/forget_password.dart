import 'package:stepOut/app/core/utils/color_resources.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            Images.loginImage,
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                const CustomAppBar(),
                customImageIcon(
                    imageName: Images.logo, height: 140, width: 160),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.h),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(25),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                      sigmaX: 0.0, sigmaY: 0.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w,
                                        vertical: 30.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Consumer<AuthProvider>(
                                        builder: (_, provider, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            getTranslated(
                                                "forget_password_header",
                                                context),
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.semiBold
                                                .copyWith(
                                                    fontSize: 22,
                                                    color:
                                                        ColorResources.HEADER),
                                          ),
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 24.h,
                                                    ),
                                                    child: CustomTextFormField(
                                                      controller:
                                                          provider.mailTEC,
                                                      hint: getTranslated(
                                                          "mail", context),
                                                      inputType: TextInputType
                                                          .emailAddress,
                                                      valid: Validations.mail,
                                                      pSvgIcon:
                                                          SvgImages.mailIcon,
                                                    ),
                                                  ),
                                                  CustomButton(
                                                      text: getTranslated(
                                                          "submit", context),
                                                      onTap: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          provider
                                                              .forgetPassword();
                                                        }
                                                      },
                                                      isLoading:
                                                          provider.isForget),
                                                ],
                                              )),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            // customImageIcon(
                            //     imageName: Images.logo,
                            //     height: 140,
                            //     width: 160),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_DEFAULT.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
