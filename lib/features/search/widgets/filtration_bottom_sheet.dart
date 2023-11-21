import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:stepOut/features/search/provider/search_provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/shimmer/custom_shimmer.dart';

class FiltrationBottomSheet extends StatelessWidget {
  const FiltrationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (_, provider, child) {
      return Column(
        children: [
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
                                  horizontal: 16.w, vertical: 8.h),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12.w,
                          ),
                          ...List.generate(
                            provider.selectedCategory?.subCategories?.length ??
                                0,
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
                                    horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: provider.selectedSubCategory ==
                                            provider.selectedCategory
                                                ?.subCategories?[index].id
                                        ? Styles.PRIMARY_COLOR
                                        : Styles.PRIMARY_COLOR
                                            .withOpacity(0.1)),
                                child: Text(
                                  provider.selectedCategory
                                          ?.subCategories?[index].name ??
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
                    (provider.servicesModel != null &&
                        provider.servicesModel!.isNotEmpty),
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
                      visible: provider.servicesModel != null &&
                          provider.servicesModel!.isNotEmpty,
                      child: AnimatedCrossFade(
                        crossFadeState: provider.selectedSubCategory == null
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 800),
                        firstChild: SizedBox(width: context.width),
                        secondChild: Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT.w),
                                ...List.generate(
                                  provider.servicesModel?.length ?? 0,
                                  (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 4.h),
                                    child: SizedBox(
                                      width: 60.w,
                                      child: InkWell(
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () => provider.onSelectService(
                                            provider.servicesModel?[index].id),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomNetworkImage
                                                .circleNewWorkImage(
                                                    radius: 30,
                                                    image: provider
                                                        .servicesModel?[index]
                                                        .image),
                                            const SizedBox(height: 4),
                                            Text(
                                              provider.servicesModel?[index]
                                                      .name ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: AppTextStyles.medium
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: Styles.TITLE),
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   margin:
                                        //       EdgeInsets.symmetric(horizontal: 6.w),
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 12.w, vertical: 6.h),
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(100),
                                        //       color: provider.selectedServices
                                        //               .contains(provider
                                        //                   .servicesModel?[index].id)
                                        //           ? Styles.PRIMARY_COLOR
                                        //           : Styles.PRIMARY_COLOR
                                        //               .withOpacity(0.1)),
                                        //   child: Text(
                                        //     provider.servicesModel?[index].name ?? "",
                                        //     style: AppTextStyles.medium.copyWith(
                                        //         fontSize: 14,
                                        //         color: provider.selectedServices
                                        //                 .contains(provider
                                        //                     .servicesModel?[index].id)
                                        //             ? Styles.WHITE_COLOR
                                        //             : Styles.PRIMARY_COLOR),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
            ],
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
    return SizedBox(
      height: 110,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
              ...List.generate(
                6,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomShimmerCircleImage(
                        diameter: 60,
                      ),
                      SizedBox(height: 4),
                      CustomShimmerText(
                        width: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
