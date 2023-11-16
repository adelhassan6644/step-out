import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../app/core/utils/app_strings.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_images.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.ITEM_DETAILS, arguments: 0),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width ?? context.width,
        decoration: BoxDecoration(
            color: Styles.SMOKED_WHITE_COLOR,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            CustomNetworkImage.containerNewWorkImage(
              edges: true,
              radius: 20,
              width: context.width,
              height: 100.h,
              image: AppStrings.networkImage,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Item Name",
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 16, color: Styles.ACCENT_COLOR),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        "4",
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 16,
                            height: 1.2,
                            color: Styles.PRIMARY_COLOR),
                      ),
                      SizedBox(width: 4.w),
                      ...List.generate(
                        4,
                        (index) => customImageIconSVG(
                            imageName: SvgImages.fillStar,
                            height: 24,
                            width: 24),
                      )
                    ],
                  ),

                  /// Description
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      "description",
                      maxLines: 2,
                      style: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.DETAILS_COLOR),
                    ),
                  ),

                  /// Location
                  Row(
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.location,
                          color: Styles.PRIMARY_COLOR),
                      SizedBox(width: 8.w),
                      Text(
                        "Location",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
