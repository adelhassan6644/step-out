import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();

  bool focusOnName = false;
  bool focusOnPhone = false;

  @override
  void initState() {
    nameNode.addListener(() {
      focusOnName = nameNode.hasFocus;
    });
    phoneNode.addListener(() {
      focusOnPhone = phoneNode.hasFocus;
    });

    Future.delayed(
        Duration.zero, () => sl<ProfileProvider>().initProfileData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("edit_profile", context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ProfileProvider>(builder: (_, provider, child) {
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
                            ///Name
                            StreamBuilder<String?>(
                                stream: provider.nameStream,
                                builder: (context, snapshot) {
                                  return CustomTextField(
                                    onChanged: provider.updateName,
                                    initialValue: provider.name.value,
                                    keyboardAction: TextInputAction.done,
                                    label: getTranslated("name", context),
                                    hint: getTranslated(
                                        "enter_your_name", context),
                                    withLabel: true,
                                    onTapOutside: (v) =>
                                        setState(() => focusOnName = false),
                                    onTap: () {
                                      setState(
                                          () => focusOnName = !focusOnName);
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
                                        provider.name
                                            .addError(Validations.name(v)!);
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
                                    initialValue: provider.phone.value,
                                    keyboardAction: TextInputAction.done,
                                    label: getTranslated("phone", context),
                                    hint: getTranslated(
                                        "enter_your_phone", context),
                                    withLabel: true,
                                    onTapOutside: (v) =>
                                        setState(() => focusOnName = false),
                                    onTap: () {
                                      setState(
                                          () => focusOnName = !focusOnName);
                                      if (!focusOnName) {
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
                                        provider.phone
                                            .addError(Validations.phone(v)!);
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
                                  text: getTranslated("save", context),
                                  onTap: () {
                                    provider.updateProfile();
                                  },
                                  isLoading: provider.isUpdate),
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
