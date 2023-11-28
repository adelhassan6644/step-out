import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../provider/search_provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Timer? timer;
  final FocusNode searchNode = FocusNode();
  bool focusOnSearch = false;

  @override
  void initState() {
    searchNode.addListener(() {
      focusOnSearch = searchNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return AnimatedCrossFade(
        crossFadeState: CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 200),
        firstChild: SizedBox(height: 0, width: context.width),
        secondChild: SizedBox(
          height: 52,
          child: TextFormField(
            controller: provider.searchTEC,
            onChanged: (v) {
              if (timer != null) if (timer!.isActive) timer!.cancel();
              timer = Timer(const Duration(milliseconds: 200), () {
                provider.getResult();
              });
            },
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(FocusNode());
              provider.getResult();
            },
            onTapOutside: (v) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            textInputAction: TextInputAction.search,
            autofocus: focusOnSearch,
            focusNode: searchNode,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL.w),
                  child: customImageIconSVG(
                      imageName: SvgImages.search,
                      color: focusOnSearch
                          ? Styles.PRIMARY_COLOR
                          : Styles.HINT_COLOR),
                ),
                suffixIcon: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    provider.clearTEC();
                  },
                  child: Visibility(
                    visible: provider.searchTEC.text.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL.w),
                      child: const Icon(
                        Icons.clear,
                        color: Styles.TITLE,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                hintText: getTranslated("search_hint", context),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 1, color: Styles.BORDER_COLOR),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 1, color: Styles.PRIMARY_COLOR),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 1, color: Styles.BORDER_COLOR),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 1, color: Styles.BORDER_COLOR),
                ),
                hintStyle: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: focusOnSearch
                        ? Styles.PRIMARY_COLOR
                        : Styles.HINT_COLOR),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h)),
          ),
        ),
      );
    });
  }
}
