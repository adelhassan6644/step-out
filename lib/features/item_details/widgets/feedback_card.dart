import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../model/item_details_model.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key, this.item});
  final FeedbackModel? item;

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
                  radius: 25, image: item?.image),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item?.name ?? "",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.TITLE),
                        maxLines: 1,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          (item?.createdAt ?? DateTime.now())
                              .dateFormat(format: "dd/MMM"),
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: Styles.DETAILS_COLOR),
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: List.generate(
                      item?.rating ?? 0,
                      (index) => customImageIconSVG(
                        height: 14,
                        width: 14,
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
            item?.comment ?? "",
            maxLines: 3,
            style: AppTextStyles.medium.copyWith(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                color: Styles.DETAILS_COLOR),
          ),
        ],
      ),
    );
  }
}
