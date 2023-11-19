import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../language/provider/localization_provider.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title,
      this.withBottomBorder = false,
      required this.icon,
      this.onTap,
      Key? key})
      : super(key: key);
  final String title, icon;
  final bool withBottomBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL.h,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: BoxDecoration(
            border: Border(
          top: const BorderSide(
            color: Styles.BORDER_COLOR,
          ),
          bottom: BorderSide(
            color: withBottomBorder ? Styles.BORDER_COLOR : Colors.transparent,
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
                imageName: icon, height: 24, width: 24, color: Styles.TITLE),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(title,
                    maxLines: 1,
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE)),
              ),
            ),
            Consumer<LocalizationProvider>(builder: (_, provider, child) {
              return RotatedBox(
                quarterTurns: provider.locale.languageCode == "ar" ? 2 : 0,
                child: customImageIconSVG(
                    color: Styles.HINT_COLOR, imageName: SvgImages.backArrow),
              );
            })
          ],
        ),
      ),
    );
  }
}
