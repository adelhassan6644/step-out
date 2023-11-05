import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/empty_widget.dart';

import '../../../app/core/utils/dimensions.dart';
import '../provider/search_provider.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListAnimator(
        customPadding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        data: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: EmptyState(
              img: Images.startSearch,
              imgWidth: context.width * 0.7,
              imgHeight: context.height * 0.35,
              txt: getTranslated("search_description", context),
            ),
          ),
        ],
      ));
    });
  }
}
