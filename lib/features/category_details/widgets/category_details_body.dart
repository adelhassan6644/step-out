import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/animated_widget.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../provider/category_details_provider.dart';
import '../../../main_widgets/item_card.dart';

class CategoryDetailsBody extends StatelessWidget {
  const CategoryDetailsBody(
      {super.key, required this.id, required this.controller});
  final int id;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(
      builder: (context, provider, child) {
        return Expanded(
            child: RefreshIndicator(
          onRefresh: () async {
            provider.getCategoryDetails(id);
          },
          color: Styles.PRIMARY_COLOR,
          child: Column(
            children: [
              Expanded(
                child: ListAnimator(
                  customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  controller: controller,
                  data: List.generate(
                    8,
                    (int index) {
                      return const ItemCard();
                    },
                  ),
                ),
              ),
            ],
          ),
        )

            // provider.isLoading
            //     ? ListAnimator(
            //         customPadding: EdgeInsets.symmetric(
            //             horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            //         data: List.generate(
            //           8,
            //           (int index) {
            //             return CustomShimmerContainer(
            //               height: 200.h,
            //               width: context.width,
            //               radius: 20,
            //             );
            //           },
            //         ),
            //       )
            //     : provider.model != null &&
            //             provider.model!.data != null &&
            //             provider.model!.data!.places != null &&
            //             provider.model!.data!.places != null &&
            //             provider.model!.data!.places!.isNotEmpty
            //         ? RefreshIndicator(
            //             onRefresh: () async {
            //               provider.getCategoryDetails(id);
            //             },
            //             color: Styles.PRIMARY_COLOR,
            //             child: Column(
            //               children: [
            //                 Expanded(
            //                   child: ListAnimator(
            //                     customPadding: EdgeInsets.symmetric(
            //                         horizontal:
            //                             Dimensions.PADDING_SIZE_DEFAULT.w),
            //                     data: List.generate(
            //                       8,
            //                       (int index) {
            //                         return const ItemCard();
            //                       },
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           )
            //         : RefreshIndicator(
            //             color: Styles.PRIMARY_COLOR,
            //             onRefresh: () async {
            //               provider.getCategoryDetails(id);
            //             },
            //             child: Column(
            //               children: [
            //                 Expanded(
            //                   child: ListAnimator(
            //                     customPadding: EdgeInsets.symmetric(
            //                         horizontal:
            //                             Dimensions.PADDING_SIZE_DEFAULT.w),
            //                     data: [
            //                       EmptyState(
            //                         imgWidth: 215.w,
            //                         imgHeight: 220.h,
            //                         spaceBtw: 12,
            //                         txt: getTranslated(
            //                             "there_is_no_data", context),
            //                         subText:
            //                             "انتظرنا حتي تكتشف معانا اماكن جديدة",
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            );
      },
    );
  }
}
