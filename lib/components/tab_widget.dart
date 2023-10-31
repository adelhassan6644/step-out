import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';

import '../app/core/utils/styles.dart';
import '../components/custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    required this.label,
    required this.isSelected,
    required this.onTap,
    Key? key,
    this.svgIcon,
  }) : super(key: key);
  final String label;
  final bool isSelected;
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
        height: 40,
        padding: EdgeInsets.symmetric(
            horizontal:  Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: 6.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2,
                    color: isSelected
                        ? Styles.PRIMARY_COLOR
                        : Styles.BORDER_COLOR))),
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
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  color: isSelected ? Styles.PRIMARY_COLOR : Styles.TITLE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
