import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_bottom_sheet.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/search/widgets/search_bar_widgtet.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../provider/search_provider.dart';
import 'filtration_bottom_sheet.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({super.key});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
        ),
        child: Row(
          children: [
            const Expanded(child: SearchBarWidget()),
            SizedBox(width: 8.w),
            customContainerSvgIcon(
              height: 45,
              width: 45,
              backGround: Styles.PRIMARY_COLOR,
              color: Styles.WHITE_COLOR,
              imageName: SvgImages.filter,
              onTap: () => CustomBottomSheet.show(
                height: context.height * 0.8,
                withPadding: false,
                list: const FiltrationBottomSheet(),
                onDismiss: () => provider.clearFilter(),
                label: getTranslated("filter", context),
                onConfirm: () {
                  CustomNavigator.pop();
                  provider.getResult();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
