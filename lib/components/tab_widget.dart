import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';

import '../app/core/utils/styles.dart';
import '../components/custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    required this.label,
     this.fontSize=16,
    this.withUpperBorder = false,
    required this.isSelected,
    required this.onTap,
    Key? key,
    this.svgIcon,
  }) : super(key: key);
  final double fontSize;
  final String label;
  final bool isSelected, withUpperBorder;
  final Function() onTap;
  final String? svgIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border(
            top: withUpperBorder
                ? const BorderSide(width: 2, color: Styles.BORDER_COLOR)
                : const BorderSide(width: 0, color: Colors.transparent),
            bottom: BorderSide(
                width: 2,
                color: isSelected ? Styles.PRIMARY_COLOR : Styles.BORDER_COLOR),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgIcon != null)
              customImageIconSVG(
                imageName: svgIcon!,
                color: isSelected
                    ? Styles.WHITE_COLOR
                    : Styles.WHITE_COLOR.withOpacity(.5),
              ),
            if (svgIcon != null) const SizedBox(width: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: AppTextStyles.semiBold.copyWith(
                overflow: TextOverflow.ellipsis,
                fontSize: fontSize,
                color: isSelected ? Styles.PRIMARY_COLOR : Styles.TITLE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
