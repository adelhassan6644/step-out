import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import 'item_details_contact_info.dart';
import 'item_details_location.dart';
import 'item_details_offers.dart';
import 'item_services_widget.dart';

class ItemDetailsInfo extends StatelessWidget {
  final ItemDetailsModel? model;
  const ItemDetailsInfo({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        customPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT.h),
        data: [
          ///Services
          const ItemServicesWidget(),

          ///Divider
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
            child: const Divider(
              color: Styles.BORDER_COLOR,
            ),
          ),

          ///Contact Info
          const ItemDetailsContactInfo(),

          ///Item Details Location
          const ItemDetailsLocation(),

          ///Divider
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
            child: const Divider(
              color: Styles.BORDER_COLOR,
            ),
          ),

          ///Item Details Offers
          const ItemDetailsOffer(),

          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}

class PlaceDetailsWidgetShimmer extends StatelessWidget {
  const PlaceDetailsWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: const BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmerContainer(
            width: 100,
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                CustomShimmerContainer(
                  width: 100,
                  height: 35,
                  radius: 100,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.location,
                    height: 18,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.phoneIcon,
                    height: 16,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                SizedBox(
                  height: 4.w,
                ),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: CustomShimmerContainer(
                      width: context.width,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomShimmerContainer(
            width: 100,
            height: 35,
            radius: 100,
          ),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
