import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {Key? key,
      this.goingDown = false,
      this.onSearch,
      this.suffixWidget,
      this.onChanged,
      this.onSuffixClick,
      this.initialValue,
      this.controller,
      this.autofocus})
      : super(key: key);

  final bool goingDown;
  final bool? autofocus;
  final Function(String)? onSearch;
  final Function(String)? onChanged;
  final Function()? onSuffixClick;
  final String? initialValue;
  final Widget? suffixWidget;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          goingDown ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
      firstChild: SizedBox(height: 0, width: context.width),
      secondChild: SizedBox(
        height: 52,
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(FocusNode());
            onSearch?.call(v);
          },
          onTapOutside: (v) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          initialValue: initialValue,
          textInputAction: TextInputAction.search,
          autofocus: autofocus ?? false,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL.w),
                child: customImageIconSVG(
                    imageName: SvgImages.search, color: Styles.HINT_COLOR),
              ),
              suffixIcon: suffixWidget,
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
              hintStyle: AppTextStyles.regular
                  .copyWith(fontSize: 14, color: Styles.HINT_COLOR),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h)),
        ),
      ),
    );
  }
}
