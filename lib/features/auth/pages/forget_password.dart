import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();

  bool focusOnEmail = false;

  @override
  void initState() {
    emailNode.addListener(() {
      focusOnEmail = emailNode.hasFocus;
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomAppBar(
                    fromAuth: true,
                    withPadding: false,
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Text(
                        getTranslated("forget_password_header", context),
                        textAlign: TextAlign.start,
                        style: AppTextStyles.semiBold
                            .copyWith(fontSize: 24, color: Styles.WHITE_COLOR),
                      ),
                    ],
                  ),
                  Text(
                    getTranslated("forget_password_description", context),
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
                                  StreamBuilder<String?>(
                                      stream: provider.mailStream,
                                      builder: (context, snapshot) {
                                        return CustomTextField(
                                          onChanged: provider.updateMail,
                                          label: getTranslated("mail", context),
                                          hint: getTranslated(
                                              "enter_your_mail", context),
                                          withLabel: true,
                                          onTapOutside: (v) => setState(
                                              () => focusOnEmail = false),
                                          onTap: () {
                                            setState(() =>
                                                focusOnEmail = !focusOnEmail);
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
                                              provider.mail.addError(
                                                  Validations.mail(v)!);
                                            }
                                            return null;
                                          },
                                        );
                                      }),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 24.h,
                                    ),
                                    child: CustomButton(
                                        text: getTranslated("submit", context),
                                        onTap: () {
                                          _formKey.currentState!.validate();
                                          if (Validations.mail(provider
                                                  .mail.value
                                                  ?.trim()) ==
                                              null) {
                                            CustomNavigator.push(
                                                Routes.VERIFICATION,
                                                arguments: false);
                                            // provider.forgetPassword();
                                          }
                                        },
                                        isLoading: provider.isForget),
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
