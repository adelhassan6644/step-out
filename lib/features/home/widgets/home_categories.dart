import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stepOut/app/core/utils/app_strings.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/grid_list_animator.dart';
import '../models/categories_model.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated("categories", context),
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 22, color: Styles.HEADER),
            ),
            provider.isGetCategories
                ? GridListAnimatorWidget(
                    aspectRatio: 0.9,
                    columnCount: 3,
                    items: List.generate(
                      9,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 3,
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: const ScaleAnimation(
                                child: FadeInAnimation(
                                    child: _CategoryCardShimmer())));
                      },
                    ),
                  )
                : provider.categoriesModel != null &&
                        provider.categoriesModel!.data != null &&
                        provider.categoriesModel!.data!.isNotEmpty
                    ? GridListAnimatorWidget(
                        aspectRatio: 0.9,
                        columnCount: 3,
                        items: List.generate(
                          provider.categoriesModel?.data?.length ?? 5,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 3,
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: _CategoryCard(
                                    item:
                                        provider.categoriesModel?.data?[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : EmptyState(
                        imgWidth: 215.w,
                        imgHeight: 220.h,
                        spaceBtw: 12,
                        txt: getTranslated("there_is_no_data", context),
                      ),
          ],
        ),
      );
    });
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryItem? item;

  const _CategoryCard({this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        CustomNavigator.push(Routes.CATEGORY_DETAILS, arguments: item);
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomNetworkImage.containerNewWorkImage(
                image: item?.image ?? AppStrings.networkImage,
                height: 100,
                width: context.width),
            SizedBox(
              height: 8.h,
            ),
            Text(
              item?.title ?? "34jkebg",
              style: AppTextStyles.medium
                  .copyWith(fontSize: 14, color: Styles.HEADER),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCardShimmer extends StatelessWidget {
  const _CategoryCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomShimmerContainer(
          radius: 18,
          height: 100,
        ),
        SizedBox(
          height: 8.h,
        ),
        const CustomShimmerContainer(
          width: 80,
          height: 15,
        )
      ],
    );
  }
}
