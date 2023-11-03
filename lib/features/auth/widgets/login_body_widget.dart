import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/features/home/models/categories_model.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  bool focusOnEmail = false;
  bool focusOnPassword = false;

  @override
  void initState() {
    emailNode.addListener(() {
      focusOnEmail = emailNode.hasFocus;
    });
    passwordNode.addListener(() {
      focusOnPassword = passwordNode.hasFocus;
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
                    StreamBuilder<String?>(
                        stream: provider.mailStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            onChanged: provider.updateMail,
                            label: getTranslated("mail", context),
                            hint: getTranslated("enter_your_mail", context),
                            withLabel: true,
                            onTap: () {
                              setState(() => focusOnEmail = !focusOnEmail);
                              if (!focusOnEmail) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            onTapOutside: (v) =>
                                setState(() => focusOnEmail = false),
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
                    StreamBuilder<String?>(
                        stream: provider.passwordStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            onChanged: provider.updatePassword,
                            keyboardAction: TextInputAction.done,
                            label: getTranslated("password", context),
                            hint: getTranslated("enter_your_password", context),
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
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            provider.clear();
                            CustomNavigator.push(Routes.FORGET_PASSWORD);
                          },
                          child: Text(
                            getTranslated("forget_password", context),
                            style: AppTextStyles.medium.copyWith(
                              color: Styles.HEADER,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: Styles.HEADER,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 24.h,
                      ),
                      child: StreamBuilder<bool?>(
                          stream: provider.loginStream,
                          builder: (context, snapshot) {
                            return CustomButton(
                                text: getTranslated("login", context),
                                onTap: () {
                                  // CustomNavigator.push(Routes.CATEGORY_DETAILS, arguments: CategoryItem());
                                  CustomNavigator.push(Routes.DASHBOARD,
                                      arguments: 0);

                                  // _formKey.currentState!.validate();
                                  // if (snapshot.data == true) {
                                  //   provider.logIn();
                                  // }
                                },
                                isLoading: provider.isLogin);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getTranslated("do_not_have_acc", context),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.medium.copyWith(
                              color: Styles.TITLE,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        ),
                        InkWell(
                          onTap: () {
                            CustomNavigator.push(Routes.REGISTER, clean: true);
                            provider.clear();
                          },
                          child: Text(
                            " ${getTranslated("signup", context)}",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.medium.copyWith(
                              color: Styles.HEADER,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        CustomNavigator.push(Routes.MAIN_PAGE, clean: true);
                        provider.clear();
                      },
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
