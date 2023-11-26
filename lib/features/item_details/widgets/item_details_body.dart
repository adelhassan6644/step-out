import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/item_details/widgets/item_details_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';
import '../provider/item_details_provider.dart';
import 'item_details_feedback.dart';
import 'item_details_images.dart';
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
            decoration: const BoxDecoration(
                color: Styles.WHITE_COLOR,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Column(
              children: [
                ///Item Detail Info
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (provider.model?.instagram != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.instagram,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                    Uri.parse(provider.model?.instagram ?? ""),
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                          if (provider.model?.facebook != null)
                            const SizedBox(width: 6),
                          if (provider.model?.facebook != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.faceBook,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                    Uri.parse(provider.model?.facebook ?? ""),
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                          const SizedBox(width: 6),
                          customContainerSvgIcon(
                            radius: 100,
                            width: 35,
                            height: 35,
                            imageName: SvgImages.export,
                            color: Styles.PRIMARY_COLOR,
                            onTap: () {},
                          ),
                          const Expanded(child: SizedBox()),
                          customImageIconSVG(
                              imageName: SvgImages.fillStar,
                              height: 20,
                              width: 20),
                          RichText(
                            text: TextSpan(
                              text:
                                  ' ${provider.model?.rating ?? 0} ${getTranslated("ratting", context)} ',
                              style: AppTextStyles.semiBold
                                  .copyWith(fontSize: 14, color: Styles.TITLE),
                              children: [
                                TextSpan(
                                  text: '(${provider.model?.totalRating ?? 0})',
                                  style: AppTextStyles.regular.copyWith(
                                      fontSize: 12, color: Styles.ACCENT_COLOR),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.h,
                          bottom: 4.h,
                        ),
                        child: Text(
                          provider.model?.name ?? "",
                          style: AppTextStyles.semiBold.copyWith(fontSize: 18),
                        ),
                      ),
                      Text(
                        provider.model?.description ?? "",
                        style: AppTextStyles.medium.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),

                ///Item Detail Tab Bar
                const ItemDetailsTabBar(),

                ///Item Detail Tabs
                if (provider.selectedTab == 0) const ItemDetailsInfo(),
                if (provider.selectedTab == 1) const ItemDetailsImages(),
                if (provider.selectedTab == 2) const ItemDetailsFeedback(),
              ],
            ),
          ),
          CustomNetworkImage.circleNewWorkImage(
              image: provider.model?.logo,
              radius: 40,
              color: Styles.PRIMARY_COLOR),
        ],
      );
    });
  }
}
