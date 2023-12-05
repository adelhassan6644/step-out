import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:stepOut/features/search/provider/search_provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/shimmer/custom_shimmer.dart';

class FiltrationBottomSheet extends StatelessWidget {
  const FiltrationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Range
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
            ),
            child: SfSlider(
              min: 0.0,
              max: 50.0,
              value: provider.range ?? 0,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              numberFormat:
                  NumberFormat("#.## ${getTranslated("km", context)}"),
              minorTicksPerInterval: 1,
              onChanged: provider.onSelectRange,
            ),
          ),

          ///Categories
          Consumer<HomeProvider>(builder: (_, categoryProvider, child) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT.w,
                        right: Dimensions.PADDING_SIZE_DEFAULT.w,
                        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                    child: Text(
                      getTranslated("categories", context),
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 18, color: Styles.HEADER),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 12.w,
                        ),
                        ...List.generate(
                          categoryProvider.categoriesModel?.data?.length ?? 0,
                          (index) => InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => provider.onSelectCategory(
                                categoryProvider.categoriesModel?.data?[index]),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 6.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: provider.selectedCategory?.id ==
                                          categoryProvider
                                              .categoriesModel?.data?[index].id
                                      ? Styles.PRIMARY_COLOR
                                      : Styles.PRIMARY_COLOR.withOpacity(0.1)),
                              child: Text(
                                categoryProvider
                                        .categoriesModel?.data?[index].name ??
                                    "",
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 16,
                                    color: provider.selectedCategory?.id ==
                                            categoryProvider.categoriesModel
                                                ?.data?[index].id
                                        ? Styles.WHITE_COLOR
                                        : Styles.PRIMARY_COLOR),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          ///Sub Categories
          AnimatedCrossFade(
            crossFadeState: provider.selectedCategory == null
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 800),
            firstChild: SizedBox(width: context.width),
            secondChild: Padding(
              padding:
                  EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT.w,
                        right: Dimensions.PADDING_SIZE_DEFAULT.w,
                        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                    child: Text(
                      provider.selectedCategory?.name ?? "",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 18, color: Styles.HEADER),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.w,
                        ),
                        ...List.generate(
                          provider.selectedCategory?.subCategories?.length ?? 0,
                          (index) => InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => provider.onSelectSubCategory(provider
                                .selectedCategory?.subCategories?[index].id),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 6.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: provider.selectedSubCategory ==
                                          provider.selectedCategory
                                              ?.subCategories?[index].id
                                      ? Styles.PRIMARY_COLOR
                                      : Styles.PRIMARY_COLOR.withOpacity(0.1)),
                              child: Text(
                                provider.selectedCategory?.subCategories?[index]
                                        .name ??
                                    "",
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 16,
                                    color: provider.selectedSubCategory ==
                                            provider.selectedCategory
                                                ?.subCategories?[index].id
                                        ? Styles.WHITE_COLOR
                                        : Styles.PRIMARY_COLOR),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///Service
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: provider.isGetServices ||
                    (provider.services != null &&
                        provider.services!.isNotEmpty),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT.w,
                      right: Dimensions.PADDING_SIZE_DEFAULT.w,
                      bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                  child: Text(
                    getTranslated("services", context),
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 18, color: Styles.HEADER),
                  ),
                ),
              ),
              provider.isGetServices
                  ? const _ShimmerLoading()
                  : Visibility(
                      visible: (provider.services != null &&
                          provider.services!.isNotEmpty),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_DEFAULT.w),
                              ...List.generate(
                                provider.services?.length ?? 0,
                                (index) => InkWell(
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () => provider.onSelectService(index),
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: provider.services?[index]
                                                    .isSelected ==
                                                true
                                            ? Styles.PRIMARY_COLOR
                                            : Styles.PRIMARY_COLOR
                                                .withOpacity(0.1)),
                                    child: Text(
                                      "${provider.services?[index].name} (${provider.services?[index].subServices?.length})",
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: provider.services?[index]
                                                      .isSelected ==
                                                  true
                                              ? Styles.WHITE_COLOR
                                              : Styles.PRIMARY_COLOR),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),

          ///Sub Service
          Visibility(
            visible: provider.services != null &&
                provider.services!.any((e) =>
                    e.isSelected! &&
                    e.subServices != null &&
                    e.subServices!.isNotEmpty),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT.w,
                      right: Dimensions.PADDING_SIZE_DEFAULT.w,
                      bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                  child: Text(
                    getTranslated("sub_services", context),
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 18, color: Styles.HEADER),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                  ),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
                          ...List.generate(
                            provider.services?.length ?? 0,
                            (i) => Visibility(
                              visible: provider.services != null &&
                                  provider.services![i].isSelected!,
                              child: Row(
                                children: List.generate(
                                  provider.services?[i].subServices?.length ??
                                      0,
                                  (v) => InkWell(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () =>
                                        provider.onSelectSubService(i, v),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: provider
                                                      .services?[i]
                                                      .subServices?[v]
                                                      .isSelected ==
                                                  true
                                              ? Styles.PRIMARY_COLOR
                                              : Styles.PRIMARY_COLOR
                                                  .withOpacity(0.1)),
                                      child: Text(
                                        provider.services?[i].subServices?[v]
                                                .name ??
                                            "",
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 14,
                                            color: provider
                                                        .services?[i]
                                                        .subServices?[v]
                                                        .isSelected ==
                                                    true
                                                ? Styles.WHITE_COLOR
                                                : Styles.PRIMARY_COLOR),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}

class _ShimmerLoading extends StatelessWidget {
  const _ShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
            ...List.generate(
              6,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: const CustomShimmerContainer(
                  width: 120,
                  height: 35,
                  radius: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
