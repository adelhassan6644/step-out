import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/app_strings.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../provider/item_details_provider.dart';

class ItemDetailsOffer extends StatelessWidget {
  const ItemDetailsOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              getTranslated("offers", context),
              style: AppTextStyles.semiBold.copyWith(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.TITLE),
            ),
          ),
          SizedBox(height: 12.h,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.w),
                ...List.generate(
                  provider.services.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    child: CustomNetworkImage.containerNewWorkImage(
                        height: 90.h,
                        width: context.width*0.7,
                        radius: 20,
                        image: AppStrings.networkImage),
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
