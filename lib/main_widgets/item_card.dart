import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_images.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.width, this.item, this.height});
  final double? width, height;
  final ItemDetailsModel? item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.ITEM_DETAILS, arguments: item?.id),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width ?? context.width,
        height: height,
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
              image: item?.cover ?? "",
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
                          item?.name ?? "Item Name",
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 14, color: Styles.ACCENT_COLOR),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        "${item?.rating?.toStringAsFixed(2) ?? 0}",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            height: 1.2,
                            color: Styles.PRIMARY_COLOR),
                      ),
                      SizedBox(width: 4.w),
                      ...List.generate(
                        item?.rating?.ceil() ?? 0,
                        (index) => customImageIconSVG(
                            imageName: SvgImages.fillStar,
                            height: 20,
                            width: 20),
                      )
                    ],
                  ),

                  /// Description
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      item?.description ?? "description",
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
                          width: 20,
                          height: 20,
                          color: Styles.PRIMARY_COLOR),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          item?.address ?? "Location",
                          maxLines: 1,
                          style: AppTextStyles.medium.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Styles.PRIMARY_COLOR),
                        ),
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
