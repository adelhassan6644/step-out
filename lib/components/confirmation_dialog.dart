import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/styles.dart';
import '../app/core/utils/svg_images.dart';
import 'custom_button.dart';
import 'custom_images.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {required this.txtBtn,
      this.txtBtn2,
      this.icon,
      this.title,
      this.description,
      this.withOneButton = false,
      this.onContinue,
      Key? key})
      : super(key: key);
  final void Function()? onContinue;
  final String txtBtn;
  final bool withOneButton;
  final String? title, description, txtBtn2;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
            visible: icon != null,
            child: customImageIcon(imageName: (icon ?? Images.success))),
        Visibility(
          visible: title != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 18, color: Styles.TITLE),
            ),
          ),
        ),
        Visibility(
          visible: description != null,
          child: Text(
            description ?? "",
            textAlign: TextAlign.center,
            style: AppTextStyles.regular
                .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        withOneButton
            ? CustomButton(
                onTap: onContinue,
                text: txtBtn,
              )
            : Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onTap: onContinue,
                    text: txtBtn,
                  )),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      child: CustomButton(
                    onTap: () => CustomNavigator.pop(),
                    text: txtBtn2 ?? "رجوع",
                    backgroundColor: Styles.PRIMARY_COLOR.withOpacity(0.1),
                    textColor: Styles.PRIMARY_COLOR,
                  ))
                ],
              )
      ],
    );
  }
}
