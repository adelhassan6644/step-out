import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/category_details_provider.dart';
import '../../../main_widgets/item_card.dart';

class CategoryDetailsBody extends StatelessWidget {
  const CategoryDetailsBody({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: provider.isLoading
              ? ListAnimator(
                  customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  data: List.generate(
                    8,
                    (int index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                      ),
                      child: CustomShimmerContainer(
                        height: 200.h,
                        width: context.width,
                        radius: 20,
                      ),
                    ),
                  ),
                )
              : provider.model != null && provider.model!.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        provider.getPlaces();
                      },
                      color: Styles.PRIMARY_COLOR,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListAnimator(
                              customPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              data: List.generate(
                                provider.model?.length ?? 0,
                                (int index) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                                  ),
                                  child: ItemCard(item: provider.model?[index]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      color: Styles.PRIMARY_COLOR,
                      onRefresh: () async {
                        provider.getPlaces();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListAnimator(
                              customPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              data: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: context.height * 0.125),
                                  child: EmptyState(
                                    imgWidth: 215.w,
                                    imgHeight: 220.h,
                                    spaceBtw: 12,
                                    txt: getTranslated(
                                        "there_is_no_data", context),
                                    subText:
                                        getTranslated("follow_up", context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
