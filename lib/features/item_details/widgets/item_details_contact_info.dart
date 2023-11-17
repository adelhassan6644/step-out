import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/components/custom_images.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';

class ItemDetailsContactInfo extends StatelessWidget {
  const ItemDetailsContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.call, width: 20, height: 20),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "123412345",
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      color: Styles.TITLE),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.clock, width: 20, height: 20),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "8 PM - 5 Am",
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            runSpacing: 8.h,
            spacing: 8.w,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
                7,
                (index) => Text(
                      "#SEAMOL",
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.PRIMARY_COLOR),
                    )),
          )
        ],
      ),
    );
  }
}
