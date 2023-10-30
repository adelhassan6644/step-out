import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/category_details_provider.dart';

class CategoryDetailsBody extends StatelessWidget {
  const CategoryDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<CategoryDetailsProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          //     child: provider.isLoading
          //         ? const CustomShimmerContainer(
          //       width: 150,
          //       height: 30,
          //     )
          //         : Text(provider.model?.data?.title ?? "",
          //         style: AppTextStyles.semiBold.copyWith(
          //             fontSize: 24,
          //             color: provider.model?.data?.textColor?.toColor)),
          //   ),
          //   provider.isLoading
          //       ? Expanded(
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //           horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          //       child: GridListAnimatorWidget(
          //         items: List.generate(
          //           8,
          //               (int index) {
          //             return AnimationConfiguration.staggeredGrid(
          //               columnCount: 2,
          //               position: index,
          //               duration: const Duration(milliseconds: 375),
          //               child: const ScaleAnimation(
          //                 child: FadeInAnimation(
          //                   child: CustomShimmerContainer(),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //   )
          //       : provider.model != null &&
          //       provider.model!.data != null &&
          //       provider.model!.data!.places != null &&
          //       provider.model!.data!.places != null &&
          //       provider.model!.data!.places!.isNotEmpty
          //       ? Expanded(
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //           horizontal:
          //           Dimensions.PADDING_SIZE_DEFAULT.w),
          //       child: GridListAnimatorWidget(
          //         items: List.generate(
          //           provider.model!.data!.places!.length,
          //               (int index) {
          //             return AnimationConfiguration.staggeredGrid(
          //               columnCount: 2,
          //               position: index,
          //               duration:
          //               const Duration(milliseconds: 375),
          //               child: ScaleAnimation(
          //                 child: FadeInAnimation(
          //                   child: PlaceCard(
          //                     place: provider
          //                         .model!.data!.places![index],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //   )
          //       : Expanded(
          //     child: RefreshIndicator(
          //       color: Styles.PRIMARY_COLOR,
          //       onRefresh: () async {
          //         provider.getCategoryDetails(widget.item);
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(
          //             horizontal:
          //             Dimensions.PADDING_SIZE_DEFAULT.w),
          //         child: ListAnimator(
          //           data: [
          //             EmptyState(
          //               imgWidth: 215.w,
          //               imgHeight: 220.h,
          //               spaceBtw: 12,
          //               txt: "لا يوجد اماكن الان",
          //               subText: "اكتشف معانا اماكن جديدة",
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        );
      },
    );
  }
}
