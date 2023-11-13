import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/search/widgets/search_bar_widgtet.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../provider/search_provider.dart';

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
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Row(
          children: [
            Expanded(
              child: SearchBarWidget(
                autofocus: true,
                controller: provider.searchTEC,
                suffixWidget: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    provider.clear();
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
                onSearch: (v) {
                  provider.getResult(v);
                },
                onChanged: (v) {
                  if (timer != null) if (timer!.isActive) timer!.cancel();
                  timer = Timer(const Duration(milliseconds: 400), () {
                    provider.getResult(v);
                  });
                },
              ),
            ),
            SizedBox(width: 8.w),
            customContainerSvgIcon(
              height: 45,
              width: 45,
              backGround: Styles.PRIMARY_COLOR,
              color: Styles.WHITE_COLOR,
              imageName: SvgImages.filter,
            )
          ],
        ),
      );
    });
  }
}
