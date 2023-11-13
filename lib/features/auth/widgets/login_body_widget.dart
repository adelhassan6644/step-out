import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/language_constant.dart';
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
        margin: EdgeInsets.only(top: context.toPadding + 160.h),
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
                    ///Mail
                    StreamBuilder<String?>(
                        stream: provider.mailStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            initialValue: provider.mail.value,
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

                    ///Password
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
                            isPassword: true,
                          );
                        }),

                    ///Forget Password && Remember me
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                      child: Row(
                        children: [
                          _RememberMe(
                            check: provider.isRememberMe,
                            onChange: (v) => provider.onRememberMe(v),
                          ),
                          const Expanded(child: SizedBox()),
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
                        ],
                      ),
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
                                  provider.clear();
                                  CustomNavigator.push(Routes.PROFILE);

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
                            provider.clear();
                            CustomNavigator.push(Routes.REGISTER, clean: true);
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
                        provider.clear();
                        CustomNavigator.push(Routes.DASHBOARD, clean: true);
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

class _RememberMe extends StatelessWidget {
  const _RememberMe({
    Key? key,
    this.check = false,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      size: 16,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              getTranslated("remember_me", context),
              maxLines: 1,
              style: AppTextStyles.medium.copyWith(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: check ? Styles.PRIMARY_COLOR : Styles.DETAILS_COLOR),
            ),
          ),
        ],
      ),
    );
  }
}
