import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode passwordNode = FocusNode();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  bool focusOnPassword = false;
  bool focusOnNewPassword = false;
  bool focusOnConfirmPassword = false;

  @override
  void initState() {
    passwordNode.addListener(() {
      focusOnPassword = passwordNode.hasFocus;
    });
    newPasswordNode.addListener(() {
      focusOnNewPassword = newPasswordNode.hasFocus;
    });
    confirmPasswordNode.addListener(() {
      focusOnConfirmPassword = confirmPasswordNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("change_password", context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<AuthProvider>(builder: (_, provider, child) {
              return Expanded(
                child: ListAnimator(
                  customPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                  ),
                  data: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            StreamBuilder<String?>(
                                stream: provider.passwordStream,
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    onChanged: provider.updatePassword,
                                    keyboardAction: TextInputAction.done,
                                    label: getTranslated(
                                        "current_password", context),
                                    hint: getTranslated(
                                        "enter_current_password", context),
                                    withLabel: true,
                                    onTapOutside: (v) =>
                                        setState(() => focusOnPassword = false),
                                    onTap: () {
                                      setState(() =>
                                          focusOnPassword = !focusOnPassword);
                                      if (!focusOnPassword) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      }
                                    },
                                    focusNode: passwordNode,
                                    alignLabel: focusOnPassword,
                                    inputType: TextInputType.visiblePassword,
                                    customError: snapshot.hasError,
                                    errorText: snapshot.error,
                                    validate: (v) {
                                      if (Validations.password(v) != null) {
                                        provider.password
                                            .addError(Validations.password(v)!);
                                      }
                                      return null;
                                    },
                                    // valid: Validations.password,
                                    isPassword: true,
                                  );
                                }),

                            ///New Password
                            StreamBuilder<String?>(
                                stream: provider.newPasswordStream,
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    onChanged: provider.updateNewPassword,
                                    keyboardAction: TextInputAction.done,
                                    label:
                                        getTranslated("new_password", context),
                                    hint: getTranslated(
                                        "enter_new_password", context),
                                    withLabel: true,
                                    onTapOutside: (v) => setState(
                                        () => focusOnNewPassword = false),
                                    onTap: () {
                                      setState(() => focusOnNewPassword =
                                          !focusOnNewPassword);
                                      if (!focusOnNewPassword) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      }
                                    },
                                    focusNode: newPasswordNode,
                                    alignLabel: focusOnNewPassword,
                                    inputType: TextInputType.visiblePassword,
                                    customError: snapshot.hasError,
                                    errorText: snapshot.error,
                                    validate: (v) {
                                      if (Validations.newPassword(
                                              provider.password.value?.trim(),
                                              v) !=
                                          null) {
                                        provider.newPassword.addError(
                                            Validations.newPassword(
                                                provider.password.value?.trim(),
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
                                    onChanged: provider.updateConfirmPassword,
                                    keyboardAction: TextInputAction.done,
                                    label: getTranslated(
                                        "confirm_new_password", context),
                                    hint: getTranslated(
                                        "enter_confirm_new_password", context),
                                    withLabel: true,
                                    onTapOutside: (v) => setState(
                                        () => focusOnConfirmPassword = false),
                                    onTap: () {
                                      setState(() => focusOnConfirmPassword =
                                          !focusOnConfirmPassword);
                                      if (!focusOnConfirmPassword) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      }
                                    },
                                    focusNode: confirmPasswordNode,
                                    alignLabel: focusOnConfirmPassword,
                                    inputType: TextInputType.visiblePassword,
                                    customError: snapshot.hasError,
                                    errorText: snapshot.error,
                                    validate: (v) {
                                      if (Validations.confirmNewPassword(
                                              provider.newPassword.value
                                                  ?.trim(),
                                              v) !=
                                          null) {
                                        provider.confirmPassword.addError(
                                            Validations.confirmNewPassword(
                                                provider.newPassword.value
                                                    ?.trim(),
                                                v)!);
                                      }
                                      return null;
                                    },
                                    // valid: Validations.password,
                                    isPassword: true,
                                  );
                                }),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 24.h,
                              ),
                              child: StreamBuilder<bool?>(
                                  stream: provider.changePasswordStream,
                                  builder: (context, snapshot) {
                                    return CustomButton(
                                        text: getTranslated("confirm", context),
                                        onTap: () {
                                          if (snapshot.data == true) {
                                            provider.changePassword();
                                          }
                                        },
                                        isLoading: provider.isChange);
                                  }),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
