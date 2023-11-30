import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:readmore/readmore.dart';
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
                  newsItem?.title ?? "",
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 18, color: Styles.ACCENT_COLOR),
                ),

                /// content
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ReadMoreText(
                      newsItem?.content ?? "",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                      trimLines: 3,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: getTranslated("show_more", context),
                      trimExpandedText: getTranslated("show_less", context),
                      textAlign: TextAlign.start,
                      moreStyle: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                      lessStyle: AppTextStyles.semiBold
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                    )),

                /// Location
                GestureDetector(
                  onTap: () async {
                    await launch(
                        'https://www.google.com/maps/search/?api=1&query=${newsItem?.lat},${newsItem?.long}');
                  },
                  child: Row(
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.location,
                          height: 20,
                          width: 20,
                          color: Styles.DETAILS_COLOR),
                      SizedBox(width: 8.w),
                      Text(
                        newsItem?.address ?? "",
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                    ],
                  ),
                ),

                /// Link
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () async =>
                        await launchUrl(Uri.parse(newsItem?.url ?? "")),
                    child: Text(
                      newsItem?.url ?? "url",
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
              image: newsItem?.image ?? "")
        ],
      ),
    );
  }
}
