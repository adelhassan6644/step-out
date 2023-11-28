import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';
import '../app/core/utils/text_styles.dart';
import 'custom_images.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double? textSize;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final String? svgIcon;
  final String? assetIcon;
  final Color? iconColor;
  final double? width;
  final double? height;
  final double? radius;
  final double? iconSize;
  final bool isLoading;
  final bool isError;
  final bool withBorderColor;
  final bool withShadow;

  const CustomButton(
      {Key? key,
      this.onTap,
      this.radius,
      this.height,
      this.svgIcon,
      this.assetIcon,
      this.isLoading = false,
      this.textColor,
      this.borderColor,
      this.width,
      this.iconColor,
      this.iconSize,
      this.textSize,
      this.withBorderColor = false,
      this.withShadow = false,
      required this.text,
      this.backgroundColor,
      this.isError = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
          width: width ?? context.width,
          height: height ?? 55.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: withShadow
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]
                : null,
            border: Border.all(
                color: withBorderColor
                    ? borderColor ?? Styles.PRIMARY_COLOR
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 15),
            gradient: backgroundColor != null
                ? null
                : const LinearGradient(
                    colors: Styles.kBackgroundGradient,
                  ),
          ),
          child: Center(
            child: isLoading
                ? SpinKitThreeBounce(
                    color: textColor ?? Styles.WHITE_COLOR,
                    size: 25,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: textSize ?? 16,
                          overflow: TextOverflow.ellipsis,
                          color: textColor ?? Styles.WHITE_COLOR,
                        ),
                      ),
                      if (assetIcon != null || svgIcon != null)
                        SizedBox(
                          width: 8.w,
                        ),
                      if (assetIcon != null)
                        customImageIcon(
                            imageName: assetIcon!,
                            color: iconColor,
                            width: iconSize ?? 20.w,
                            height: iconSize ?? 20.w),
                      if (svgIcon != null)
                        customImageIconSVG(
                            imageName: svgIcon!,
                            color: iconColor,
                            width: iconSize ?? 20.w,
                            height: iconSize ?? 20.w),
                    ],
                  ),
          ),
        ));
  }
}
