import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/app_strings.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, this.newsItem});
  final NewsItem? newsItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.only(
        bottom: Dimensions.PADDING_SIZE_SMALL.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Styles.BORDER_COLOR),
        color: Styles.FILL_COLOR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  "title",
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 18, color: Styles.ACCENT_COLOR),
                ),

                /// Description
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "description",
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                  ),
                ),

                /// Location
                Row(
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.location,
                        color: Styles.DETAILS_COLOR),
                    SizedBox(width: 8.w),
                    Text(
                      "Location",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    ),
                  ],
                ),

                /// Link
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () async => await launchUrl(Uri.parse(
                        "https://www.bbc.com/news/live/world-middle-east-67223217")),
                    child: Text(
                      "https://www.bbc.com/news/live/world-middle-east-67223217",
                      maxLines: 1,
                      style: AppTextStyles.semiBold.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///Image
          CustomNetworkImage.containerNewWorkImage(
              height: 120,
              width: context.width,
              radius: 16,
              image: AppStrings.networkImage)
        ],
      ),
    );
  }
}
