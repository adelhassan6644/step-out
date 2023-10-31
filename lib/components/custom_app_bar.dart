import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withBack;
  final bool withPadding;
  final double? height;
  final Color? backIconColor;
  final double? actionWidth;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.height,
      this.withPadding = true,
      this.withBack = true,
      this.backIconColor,
      this.actionWidth,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: withPadding ? Dimensions.PADDING_SIZE_DEFAULT.w : 0,
      ),
      child: Column(
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          Row(
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
                            child: customImageIconSVG(
                                color: backIconColor ?? Colors.black,
                                imageName: SvgImages.backArrow)),
                      ))
                  : SizedBox(
                      width: actionWidth ?? 30,
                    ),
              const Expanded(child: SizedBox()),
              Text(
                title ?? "",
                style: AppTextStyles.semiBold
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: actionWidth ?? 30,
                width: actionWidth ?? 30,
                child: actionChild ?? const SizedBox(),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(CustomNavigator.navigatorState.currentContext!.width, height ?? 50);
}
