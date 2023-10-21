import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  bool focusOnPassword = false;
  bool focusOnConfirmPassword = false;

  @override
  void initState() {
    passwordNode.addListener(() {
      focusOnPassword = passwordNode.hasFocus;
    });
    confirmPasswordNode.addListener(() {
      focusOnConfirmPassword = confirmPasswordNode.hasFocus;
    });
    super.initState();
  }

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
                    backIconColor: Styles.WHITE_COLOR,
                    withPadding: false,
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Text(
                        getTranslated("reset_password_header", context),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 24, color: Styles.WHITE_COLOR),
                      ),
                    ],
                  ),
                  Text(
                    getTranslated("reset_password_description", context),
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
                                  ///New Password
                                  StreamBuilder<String?>(
                                      stream: provider.newPasswordStream,
                                      builder: (context, snapshot) {
                                        return CustomTextField(
                                          onChanged: provider.updateNewPassword,
                                          label: getTranslated(
                                              "new_password", context),
                                          hint: getTranslated(
                                              "enter_new_password", context),
                                          withLabel: true,
                                          onTapOutside: (v) => setState(
                                              () => focusOnPassword = false),

                                          onTap: () {
                                            setState(() => focusOnPassword =
                                                !focusOnPassword);
                                            if (!focusOnPassword) {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            }
                                          },
                                          focusNode: passwordNode,
                                          alignLabel: focusOnPassword,
                                          inputType:
                                              TextInputType.visiblePassword,
                                          customError: snapshot.hasError,
                                          errorText: snapshot.error,
                                          validate: (v) {
                                            if (Validations.firstPassword(v) !=
                                                null) {
                                              provider.newPassword.addError(
                                                  Validations.firstPassword(
                                                      v)!);
                                            }
                                            return null;
                                          },
                                          // valid: Validations.password,
                                          isPassword: true,
                                        );
                                      }),

                                  ///Confirm New Password
                                  StreamBuilder<String?>(
                                      stream: provider.confirmPasswordStream,
                                      builder: (context, snapshot) {
                                        return CustomTextField(
                                          onChanged:
                                              provider.updateConfirmPassword,
                                          keyboardAction: TextInputAction.done,
                                          label: getTranslated(
                                              "confirm_new_password", context),
                                          hint: getTranslated(
                                              "enter_confirm_new_password",
                                              context),
                                          withLabel: true,
                                          onTapOutside: (v) => setState(() =>
                                              focusOnConfirmPassword = false),
                                          onTap: () {
                                            setState(() =>
                                                focusOnConfirmPassword =
                                                    !focusOnConfirmPassword);
                                            if (!focusOnConfirmPassword) {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            }
                                          },
                                          focusNode: confirmPasswordNode,
                                          alignLabel: focusOnConfirmPassword,
                                          inputType:
                                              TextInputType.visiblePassword,
                                          customError: snapshot.hasError,
                                          errorText: snapshot.error,
                                          validate: (v) {
                                            if (Validations.confirmNewPassword(
                                                    provider.newPassword.value
                                                        ?.trim(),
                                                    v) !=
                                                null) {
                                              provider.confirmPassword.addError(
                                                  Validations
                                                      .confirmNewPassword(
                                                          provider
                                                              .newPassword.value
                                                              ?.trim(),
                                                          v)!);
                                            }
                                            return null;
                                          },
                                          isPassword: true,
                                        );
                                      }),

                                  ///Confirm
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    child: StreamBuilder<bool?>(
                                        stream: provider.resetPasswordStream,
                                        builder: (context, snapshot) {
                                          return CustomButton(
                                              text: getTranslated(
                                                  "submit", context),
                                              onTap: () {
                                                _formKey.currentState!
                                                    .validate();

                                                if (snapshot.hasData) {
                                                  if (snapshot.data!) {
                                                    provider.resetPassword();
                                                  }
                                                }
                                              },
                                              isLoading: provider.isReset);
                                        }),
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
