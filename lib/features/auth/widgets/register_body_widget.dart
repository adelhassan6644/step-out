import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({super.key});

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  bool focusOnName = false;
  bool focusOnPhone = false;
  bool focusOnEmail = false;
  bool focusOnPassword = false;
  bool focusOnConfirmPassword = false;

  @override
  void initState() {
    nameNode.addListener(() {
      focusOnName = nameNode.hasFocus;
    });
    phoneNode.addListener(() {
      focusOnPhone = phoneNode.hasFocus;
    });
    emailNode.addListener(() {
      focusOnEmail = emailNode.hasFocus;
    });
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
    return Consumer<AuthProvider>(builder: (_, provider, child) {
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
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: ListAnimator(
          data: [
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT.h,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///Name
                    StreamBuilder<String?>(
                        stream: provider.nameStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            onChanged: provider.updateName,
                            label: getTranslated("name", context),
                            hint: getTranslated("enter_your_name", context),
                            withLabel: true,
                            onTapOutside: (v) =>
                                setState(() => focusOnName = false),
                            onTap: () {
                              setState(() => focusOnName = !focusOnName);
                              if (!focusOnName) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            focusNode: nameNode,
                            alignLabel: focusOnName,
                            inputType: TextInputType.name,
                            customError: snapshot.hasError,
                            errorText: snapshot.error,
                            validate: (v) {
                              if (Validations.name(v) != null) {
                                provider.name.addError(Validations.name(v)!);
                              }
                              return null;
                            },
                          );
                        }),

                    ///Phone
                    StreamBuilder<String?>(
                        stream: provider.phoneStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            onChanged: provider.updatePhone,
                            label: getTranslated("phone", context),
                            hint: getTranslated("enter_your_phone", context),
                            withLabel: true,
                            onTapOutside: (v) =>
                                setState(() => focusOnPhone = false),
                            onTap: () {
                              setState(() => focusOnPhone = !focusOnPhone);
                              if (!focusOnPhone) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            focusNode: phoneNode,
                            alignLabel: focusOnPhone,
                            inputType: TextInputType.phone,
                            customError: snapshot.hasError,
                            errorText: snapshot.error,
                            validate: (v) {
                              if (Validations.phone(v) != null) {
                                provider.phone.addError(Validations.phone(v)!);
                              }
                              return null;
                            },
                          );
                        }),

                    ///E-Mail
                    StreamBuilder<String?>(
                        stream: provider.mailStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            initialValue: provider.mail.value,
                            onChanged: provider.updateMail,
                            label: getTranslated("mail", context),
                            hint: getTranslated("enter_your_mail", context),
                            withLabel: true,
                            onTapOutside: (v) =>
                                setState(() => focusOnEmail = false),
                            onTap: () {
                              setState(() => focusOnEmail = !focusOnEmail);
                              if (!focusOnEmail) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            focusNode: emailNode,
                            alignLabel: focusOnEmail,
                            inputType: TextInputType.emailAddress,
                            customError: snapshot.hasError,
                            errorText: snapshot.error,
                            validate: (v) {
                              if (Validations.mail(v) != null) {
                                provider.mail.addError(Validations.mail(v)!);
                              }
                              return null;
                            },
                          );
                        }),

                    ///New Password
                    StreamBuilder<String?>(
                        stream: provider.newPasswordStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            onChanged: provider.updateNewPassword,
                            label: getTranslated("new_password", context),
                            hint: getTranslated("enter_new_password", context),
                            withLabel: true,
                            onTapOutside: (v) =>
                                setState(() => focusOnPassword = false),
                            onTap: () {
                              setState(
                                  () => focusOnPassword = !focusOnPassword);
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
                              if (Validations.firstPassword(v) != null) {
                                provider.newPassword
                                    .addError(Validations.firstPassword(v)!);
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
                            label:
                                getTranslated("confirm_new_password", context),
                            hint: getTranslated(
                                "enter_confirm_new_password", context),
                            withLabel: true,
                            onTapOutside: (v) =>
                                setState(() => focusOnConfirmPassword = false),
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
                                      provider.newPassword.value?.trim(), v) !=
                                  null) {
                                provider.confirmPassword.addError(
                                    Validations.confirmNewPassword(
                                        provider.newPassword.value?.trim(),
                                        v)!);
                              }
                              return null;
                            },
                            isPassword: true,
                          );
                        }),

                    ///Accept Terms & Conditions
                    _AgreeToTerms(
                      check: provider.isAgree,
                      onChange: (v) => provider.onAgree(v),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      child: StreamBuilder<bool?>(
                          stream: provider.registerStream,
                          builder: (context, snapshot) {
                            return CustomButton(
                                text: getTranslated("signup", context),
                                onTap: () {
                                  _formKey.currentState!.validate();

                                  if (snapshot.hasData) {
                                    if (snapshot.data!) {
                                      if (provider.isAgree) {
                                        provider.register();
                                      } else {
                                        showToast(getTranslated(
                                            "oops_you_must_agree_to_terms_and_conditions",
                                            context));
                                      }
                                    }
                                  }
                                },
                                isLoading: provider.isRegister);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("have_acc", context),
                            textAlign: TextAlign.end,
                            style: AppTextStyles.medium.copyWith(
                                color: Styles.TITLE,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              CustomNavigator.push(Routes.LOGIN, clean: true);
                              provider.clear();
                            },
                            child: Text(
                              " ${getTranslated("login", context)}",
                              style: AppTextStyles.medium.copyWith(
                                color: Styles.HEADER,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                decorationColor: Styles.HEADER,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => provider.logInAsAGuest(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text(
                          getTranslated("login_as_a_guest", context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold
                              .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }
}

class _AgreeToTerms extends StatelessWidget {
  const _AgreeToTerms({
    Key? key,
    this.check = false,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 8.h),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => onChange(!check),
            child: Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: check ? Styles.PRIMARY_COLOR : Styles.WHITE_COLOR,
                  border: Border.all(
                      color:
                          check ? Styles.PRIMARY_COLOR : Styles.DETAILS_COLOR,
                      width: 1)),
              child: check
                  ? const Icon(
                      Icons.check,
                      color: Styles.WHITE_COLOR,
                      size: 14,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            getTranslated("agree_to", context),
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
          ),
          Expanded(
            child: InkWell(
              onTap: () => CustomNavigator.push(Routes.TERMS),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Text(
                " ${getTranslated("terms_conditions", context)} ",
                maxLines: 1,
                style: AppTextStyles.semiBold.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    decoration: TextDecoration.underline,
                    color: Styles.PRIMARY_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
