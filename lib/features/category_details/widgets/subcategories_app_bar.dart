import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../language/provider/localization_provider.dart';

class SubcategoriesAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String? title;
  final TextEditingController? controller;

  const SubcategoriesAppBar({
    Key? key,
    this.title,
    this.controller,
  }) : super(key: key);

  @override
  State<SubcategoriesAppBar> createState() => _SubcategoriesAppBarState();

  @override
  Size get preferredSize =>
      Size(CustomNavigator.navigatorState.currentContext!.width, 50);
}

class _SubcategoriesAppBarState extends State<SubcategoriesAppBar> {
  Timer? timer;
  bool showSearch = false;

  double _checkValue(bool value) => value ? (context.width - 40.w) : 18.w;
  bool _checkLang() => sl<LocalizationProvider>().locale.languageCode == "en";

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: showSearch ? 0 : 8.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  child: showSearch
                      ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (v) {
                                  if (timer != null) {
                                    if (timer!.isActive) {
                                      timer!.cancel();
                                    }
                                  }
                                  timer = Timer(
                                      const Duration(milliseconds: 200), () {});
                                },
                                controller: provider.searchTEC,
                                autofocus: true,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefix: SizedBox(width: 16.w),
                                  hintText:
                                      getTranslated("search_hint", context),
                                  hintStyle: AppTextStyles.regular.copyWith(
                                      fontSize: 14, color: Styles.HINT_COLOR),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 16.w),
                                ),
                                style: AppTextStyles.semiBold.copyWith(
                                    fontSize: 16, color: Styles.HEADER),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: showSearch ? 1 : 0,
                              duration: const Duration(milliseconds: 400),
                              child: InkWell(
                                onTap: () {
                                  setState(() => showSearch = false);
                                  provider.searchTEC.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    getTranslated("cancel", context),
                                    style: AppTextStyles.semiBold.copyWith(
                                      color: Styles.HEADER,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                              width: 30,
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              widget.title ?? "",
                              style: AppTextStyles.semiBold
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                            const Expanded(child: SizedBox()),
                            const SizedBox(
                              height: 30,
                              width: 30,
                            )
                          ],
                        )),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: 8.h,
                left: _checkValue(showSearch),
                right: _checkValue(!showSearch),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: customImageIconSVG(
                      imageName: SvgImages.search,
                      color: Colors.black,
                      onTap: () {
                        setState(() => showSearch = true);
                      }),
                ),
              ),
              Positioned(
                right: _checkLang() ? context.width - 36.w : null,
                left: _checkLang() ? null : context.width - 36.w,
                top: 8.h,
                child: AnimatedOpacity(
                  opacity: showSearch ? 0 : 1,
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                        child: customImageIconSVG(
                            onTap: () {
                              if (!showSearch) {
                                CustomNavigator.pop();
                              }
                            },
                            color: Colors.black,
                            imageName: SvgImages.backArrow)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
