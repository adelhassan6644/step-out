import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import '../app/core/utils/images.dart';
import '../app/core/utils/svg_images.dart';
import '../app/localization/language_constant.dart';
import 'custom_images.dart';

class EmptyState extends StatelessWidget {
  final String? img;
  final double? imgHeight;
  final double? emptyHeight;
  final double? imgWidth;
  final bool isSvg;
  final double? spaceBtw;
  final String? txt;
  final String? subText;
  final bool withImage;

  const EmptyState({
    Key? key,
    this.emptyHeight,
    this.spaceBtw,
    this.isSvg = false,
    this.withImage = true,
    this.img,
    this.imgHeight,
    this.imgWidth,
    this.txt,
    this.subText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (withImage)
          !isSvg
              ? SizedBox(
                  width: imgWidth ?? context.width * 0.45,
                  height: imgHeight ?? context.height * 0.19,
                  child: customImageIcon(
                    imageName: img ?? Images.logo,
                  ),
                ) //width: MediaQueryHelper.width*.8,),
              : SizedBox(
            width: imgWidth ?? context.width * 0.45,
            height: imgHeight ?? context.height * 0.19,
                child: customImageIconSVG(
                    imageName: img ?? SvgImages.appLogo,

                    color: Styles.PRIMARY_COLOR),
              ),
        SizedBox(
          height: spaceBtw ?? 12.h,
        ),
        Text(txt ?? getTranslated("there_is_no_data", context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Styles.PRIMARY_COLOR,
            )),
        SizedBox(height: 8.h),
        Text(subText ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                color: Styles.PRIMARY_COLOR,
                fontWeight: FontWeight.w400))
      ],
    ));
  }
}
