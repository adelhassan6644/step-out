import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/item_details/widgets/item_details_info.dart';

import '../../../app/core/utils/styles.dart';
import '../../../components/custom_network_image.dart';
import '../provider/item_details_provider.dart';
import 'item_details_tab_bar.dart';

class ItemDetailsBody extends StatelessWidget {
  const ItemDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: context.width,
            margin: const EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            decoration: const BoxDecoration(
                color: Styles.WHITE_COLOR,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Column(
              children: [
                ///Item Detail Info
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: ' (142) ',
                        style: AppTextStyles.regular
                            .copyWith(fontSize: 14, color: Styles.ACCENT_COLOR),
                        children: [
                          TextSpan(
                            text: 'Rating',
                            style: AppTextStyles.semiBold
                                .copyWith(fontSize: 16, color: Styles.TITLE),
                          ),
                          TextSpan(
                            text: ' 4.0  ',
                            style: AppTextStyles.semiBold
                                .copyWith(fontSize: 16, color: Styles.TITLE),
                          ),
                        ],
                      ),
                    ),
                    customImageIconSVG(
                        imageName: SvgImages.fillStar, height: 24),
                    const Expanded(child: SizedBox()),
                    customContainerSvgIcon(
                      radius: 100,
                      width: 40,
                      height: 40,
                      imageName: SvgImages.export,
                      color: Styles.PRIMARY_COLOR,
                    ),
                    const SizedBox(width: 6),
                    customContainerSvgIcon(
                      radius: 100,
                      width: 40,
                      height: 40,
                      imageName: SvgImages.faceBook,
                      color: Styles.PRIMARY_COLOR,
                    ),
                    const SizedBox(width: 6),
                    customContainerSvgIcon(
                      radius: 100,
                      width: 40,
                      height: 40,
                      imageName: SvgImages.instagram,
                      color: Styles.PRIMARY_COLOR,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    "Aroma",
                    style: AppTextStyles.semiBold.copyWith(fontSize: 18),
                  ),
                ),
                Text(
                  "Cafe` & Restaurant",
                  style: AppTextStyles.medium.copyWith(fontSize: 14),
                ),
                SizedBox(height: 24.h),

                ///Item Detail Tab Bar
                const ItemDetailsTabBar(),

                ///Item Detail Tabs
                if (provider.selectedTab == 0) const ItemDetailsInfo(),
                if (provider.selectedTab == 1) const SizedBox(),
                if (provider.selectedTab == 2) const SizedBox(),
              ],
            ),
          ),
          CustomNetworkImage.circleNewWorkImage(
              radius: 40, color: Styles.PRIMARY_COLOR),
        ],
      );
    });
  }
}
