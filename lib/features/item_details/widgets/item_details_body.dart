import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
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
import '../../../components/image_pop_up_viewer.dart';
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
                          if (provider.model?.instagram != null)
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
                          if (provider.model?.facebook != null)
                            const SizedBox(width: 6),
                          if (provider.model?.whatsapp != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.whatsApp,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                    'whatsapp://send?phone=${provider.model?.whatsapp}',
                                  ),
                                );
                              },
                            ),
                          // customContainerSvgIcon(
                          //   radius: 100,
                          //   width: 35,
                          //   height: 35,
                          //   imageName: SvgImages.export,
                          //   color: Styles.PRIMARY_COLOR,
                          //   onTap: () => provider.sharePlace(),
                          // ),
                          const Expanded(child: SizedBox()),
                          if (provider.model?.twitter != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.twitter,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                    Uri.parse(provider.model?.twitter ?? ""),
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                          if (provider.model?.tiktok != null)
                            const SizedBox(width: 6),
                          if (provider.model?.tiktok != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.tiktok,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                    Uri.parse(provider.model?.tiktok ?? ""),
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                          if (provider.model?.snapchat != null)
                            const SizedBox(width: 6),
                          if (provider.model?.snapchat != null)
                            customContainerSvgIcon(
                              radius: 100,
                              width: 35,
                              height: 35,
                              imageName: SvgImages.snapchat,
                              color: Styles.PRIMARY_COLOR,
                              onTap: () {
                                launchUrl(
                                    Uri.parse(provider.model?.snapchat ?? ""),
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                        ],
                      ),

                      ///Title
                      Text(
                        provider.model?.name ?? "",
                        style: AppTextStyles.semiBold.copyWith(fontSize: 18),
                      ),

                      ///Ratting
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customImageIconSVG(
                              imageName: SvgImages.fillStar,
                              height: 16,
                              width: 16),
                          RichText(
                            text: TextSpan(
                              text:
                                  ' ${provider.model?.rating?.toStringAsFixed(2) ?? 0} ${getTranslated("ratting", context)} ',
                              style: AppTextStyles.semiBold
                                  .copyWith(fontSize: 12, color: Styles.TITLE),
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

                      ///Description
                      SizedBox(
                        height: 8.h,
                      ),
                      ReadMoreText(
                        provider.model?.description ?? "",
                        style: AppTextStyles.medium.copyWith(fontSize: 14),
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: getTranslated("show_more", context),
                        trimExpandedText: getTranslated("show_less", context),
                        textAlign: TextAlign.start,
                        moreStyle: AppTextStyles.semiBold.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                        lessStyle: AppTextStyles.semiBold.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
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
          InkWell(
            onTap: () {
              Future.delayed(
                  Duration.zero,
                  () => showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.75),
                      builder: (context) {
                        return ImagePopUpViewer(
                          image: provider.model?.logo,
                          isFromInternet: true,
                          title: "",
                        );
                      }));
            },
            child: CustomNetworkImage.circleNewWorkImage(
                image: provider.model?.logo,
                radius: 40,
                color: Styles.PRIMARY_COLOR),
          ),
        ],
      );
    });
  }
}
