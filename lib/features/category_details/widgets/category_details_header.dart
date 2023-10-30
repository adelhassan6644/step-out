import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stepOut/components/tab_widget.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';

import '../../../app/core/utils/dimensions.dart';

class CategoryDetailsHeader extends StatelessWidget {
  const CategoryDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) => Expanded(
                            child: AutoScrollTag(
                              controller: provider.controller1,
                              index: index,
                              key: ValueKey(index),
                              child: TabWidget(
                                title: provider.subCategories[index],
                                isSelected:
                                    provider.selectedSubCategory == index,
                                onTab: () =>
                                    provider.onSelectSubCategory(index),
                              ),
                            ),
                          ),
                      separatorBuilder: (_, index) => SizedBox(
                            width: 12.w,
                          ),
                      itemCount: provider.subCategories.length),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
