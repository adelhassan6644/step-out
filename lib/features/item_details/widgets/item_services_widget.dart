import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/app_strings.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/provider/item_details_provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';

class ItemServicesWidget extends StatelessWidget {
  const ItemServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 6.0.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              getTranslated("our_services", context),
              style: AppTextStyles.semiBold.copyWith(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.TITLE),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
                ...List.generate(
                  provider.services.length,
                  (index) => InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    // onTap: () => provider.onSelectFilter(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 4.h),
                          child: CustomNetworkImage.circleNewWorkImage(
                              radius: 30, image: AppStrings.networkImage),
                        ),
                        Text(
                          provider.services[index],
                          style: AppTextStyles.medium
                              .copyWith(fontSize: 14, color: Styles.TITLE),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
