import 'package:flutter/cupertino.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
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

class ItemDetailsInfo extends StatelessWidget {
  final ItemDetailsModel? model;
  const ItemDetailsInfo({super.key, this.model});

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
          Text(
            model?.category ?? "",
            style: AppTextStyles.light.copyWith(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                color: model?.nameColor?.toColor),
            maxLines: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    model?.name ?? "",
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 22,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE),
                    maxLines: 1,
                  ),
                ),
                CustomButton(
                  text: getTranslated("share", context),
                  width: 110,
                  height: 35,
                  withBorderColor: false,
                  withShadow: true,
                  iconSize: 15,
                  textColor: Styles.ACCENT_COLOR,
                  svgIcon: SvgImages.share,
                  backgroundColor: Styles.WHITE_COLOR,
                  textSize: 14,
                )
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
                Expanded(
                  child: Text(
                    model?.address ?? "",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: const Color(0xFF656565),
                    ),
                    maxLines: 2,
                  ),
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
                Expanded(
                  child: Text(
                    model?.phone ?? "",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: const Color(0xFF656565),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: model?.description != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "وصف",
                          style: AppTextStyles.light.copyWith(
                            fontSize: 16,
                            color: const Color(0xFF656565),
                          ),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Text(
                          model?.description ?? "",
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.DETAILS_COLOR,
                          ),
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                      ],
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customContainerSvgIcon(
                        imageName: SvgImages.faceBook,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: Styles.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(model?.facebook ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    customContainerSvgIcon(
                        imageName: SvgImages.instagram,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: Styles.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(model?.instagram! ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                  ],
                )
              ],
            ),
          ),
          CustomButton(
            text: getTranslated("location", context),
            onTap: () async {
              await launch(
                  'https://www.google.com/maps/search/?api=1&query=${model?.lat},${model?.long}');
            },
          ),
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