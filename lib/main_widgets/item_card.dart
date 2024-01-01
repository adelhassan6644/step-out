import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/methods.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_images.dart';
import '../features/maps/provider/location_provider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.width, this.item});
  final double? width;
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
        decoration: BoxDecoration(
            color: Styles.SMOKED_WHITE_COLOR,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  ///Name
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
                        item?.rating?.ceil() != 0
                            ? item?.rating?.ceil() ?? 0
                            : 1,
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
                      maxLines: 1,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.TITLE),
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

                  /// Distance
                  const SizedBox(height: 6),
                  Consumer<LocationProvider>(builder: (_, provider, child) {
                    return Row(
                      children: [
                        customImageIconSVG(
                            imageName: SvgImages.distance,
                            width: 20,
                            height: 20,
                            color: Styles.SUBTITLE),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: FutureBuilder(
                            future: Methods.calcLiveDistance(
                                lat: item?.lat, long: item?.long),
                            builder: (_, AsyncSnapshot<dynamic> snapshot) {
                              return Expanded(
                                child: Text(
                                  "${getTranslated("away_from_you", context)} ${snapshot.data ?? "..."} ${getTranslated("km", context)}",
                                  style: AppTextStyles.regular.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      color: Styles.SUBTITLE),
                                ),
                              );
                            },
                          ),

                          // Text(
                          //   "${getTranslated("away_from_you", context)} ${Methods.calcLiveDistance(lat: item?.lat, long: item?.long)} ${getTranslated("km", context)}",
                          //   style: AppTextStyles.regular.copyWith(
                          //       overflow: TextOverflow.ellipsis,
                          //       fontSize: 12,
                          //       color: Styles.SUBTITLE),
                          // ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
