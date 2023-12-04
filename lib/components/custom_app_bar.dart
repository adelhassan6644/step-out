import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/text_styles.dart';
import '../data/config/di.dart';
import '../features/language/provider/localization_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withBack;
  final bool withHPadding;
  final bool withVPadding;
  final double? height;
  final bool withSafeArea;
  final Color? backColor;
  final double? actionWidth;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.height,
      this.backColor,
      this.withHPadding = true,
      this.withVPadding = true,
      this.withBack = true,
      this.withSafeArea = true,
      this.actionWidth,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: withSafeArea,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: withHPadding ? Dimensions.PADDING_SIZE_DEFAULT.w : 0,
          vertical: withVPadding ? Dimensions.PADDING_SIZE_EXTRA_SMALL.h : 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withBack
                ? InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      CustomNavigator.pop();
                    },
                    child: SizedBox(
                      height: actionWidth ?? 30,
                      width: actionWidth ?? 30,
                      child: Center(
                          child: RotatedBox(
                        quarterTurns:
                            sl<LocalizationProvider>().locale.languageCode ==
                                    "ar"
                                ? 0
                                : 2,
                        child: customImageIconSVG(
                            color: backColor ?? Colors.black,
                            imageName: SvgImages.backArrow),
                      )),
                    ))
                : SizedBox(
                    width: actionWidth ?? 30,
                  ),
            const Expanded(child: SizedBox()),
            Text(
              title ?? "",
              style: AppTextStyles.semiBold
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: actionWidth ?? 30,
              width: actionWidth ?? 30,
              child: actionChild ?? const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(CustomNavigator.navigatorState.currentContext!.width, height ?? 50);
}
