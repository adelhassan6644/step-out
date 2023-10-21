import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final void Function(String?)? onSave;
  final void Function(String) onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validation;

  const CustomPinCodeField(
      {super.key,
      this.onSave,
      this.validation,
      required this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Styles.HEADER,
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      autoDismissKeyboard: true,
      enableActiveFill: true,
      controller: controller,
      enablePinAutofill: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      textStyle: AppTextStyles.semiBold.copyWith(color: Styles.HEADER),
      pastedTextStyle: AppTextStyles.semiBold.copyWith(color: Styles.HEADER),
      textInputAction: TextInputAction.done,
      pinTheme: PinTheme(
        borderWidth: 1,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60.h,
        fieldWidth: 60.w,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
        activeFillColor: Styles.HEADER.withOpacity(0.05),
        activeColor: Styles.HEADER,
        inactiveColor: Styles.LIGHT_BORDER_COLOR,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        selectedColor: Styles.PRIMARY_COLOR,
        disabledColor: Styles.FILL_COLOR,
        errorBorderColor: Styles.FAILED_COLOR,
      ),
      appContext: context,
      length: 4,
      onSaved: onSave,
      onChanged: onChanged,
      errorTextSpace: 30,
    );
  }
}
