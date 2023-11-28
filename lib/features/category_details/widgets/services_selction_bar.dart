import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../provider/category_details_provider.dart';

class ServicesSelectionBar extends StatelessWidget {
  const ServicesSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return provider.isGetServices
          ? const _ShimmerLoading()
          : Visibility(
              visible: provider.services != null &&
                  provider.services!.isNotEmpty,
              child: AnimatedCrossFade(
                crossFadeState: provider.goingDown
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 800),
                firstChild: SizedBox(width: context.width),
                secondChild: Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
                        ...List.generate(
                          provider.services?.length ?? 0,
                          (index) => InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => provider.onSelectService(
                                provider.services?[index].id),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 6.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: provider.selectedServicesId.contains(
                                          provider.services?[index].id)
                                      ? Styles.PRIMARY_COLOR
                                      : Styles.PRIMARY_COLOR.withOpacity(0.1)),
                              child: Text(
                                provider.services?[index].name ?? "",
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14,
                                    color: provider.selectedServicesId.contains(
                                            provider.services?[index].id)
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
              ),
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
