import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/features/search/widgets/search_result_card.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../components/custom_loading.dart';
import '../provider/search_provider.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListAnimator(
        data: [
          ///Start State
          Visibility(
            visible: !provider.isLoading &&
                provider.searchTEC.text.isEmpty &&
                provider.result.isEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: context.height * 0.2),
              child: EmptyState(
                img: Images.startSearch,
                imgWidth: context.width * 0.7,
                imgHeight: context.height * 0.35,
                txt: getTranslated("search_description", context),
              ),
            ),
          ),

          ///Loading State
          Visibility(
            visible: provider.isLoading,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: context.height * 0.2),
                child: const CustomLoading()),
          ),

          ///Result State
          Visibility(
            visible: !provider.isLoading && provider.result.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  provider.result.length,
                  (index) => SearchResultCard(
                        item: provider.result[index],
                      )),
            ),
          ),

          ///Empty State
          Visibility(
            visible: !provider.isLoading &&
                provider.searchTEC.text.isNotEmpty &&
                provider.result.isEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: context.height * 0.2),
              child: EmptyState(
                img: Images.emptySearch,
                imgWidth: context.width * 0.7,
                imgHeight: context.height * 0.3,
                txt: getTranslated("no_result_found", context),
                subText: getTranslated("no_result_found_description", context),
              ),
            ),
          ),
        ],
      ));
    });
  }
}
