import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/app_strings.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/components/custom_network_image.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: BoxDecoration(
        color: Styles.SMOKED_WHITE_COLOR,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomNetworkImage.circleNewWorkImage(
                  radius: 25, image: AppStrings.networkImage),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jon Due",
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE),
                    maxLines: 1,
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => customImageIconSVG(
                        height: 15,
                        width: 15,
                        color: 2 < index ? Styles.DETAILS_COLOR : Colors.amber,
                        imageName: 2 < index
                            ? SvgImages.emptyStar
                            : SvgImages.fillStar,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,",
            maxLines: 3,
            style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
                color: Styles.DETAILS_COLOR),
          ),
        ],
      ),
    );
  }
}
