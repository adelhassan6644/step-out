import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/utils/text_styles.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, this.item});
  final ItemDetailsModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
      decoration: const BoxDecoration(
        color: Styles.WHITE_COLOR,
        border: Border(
          bottom: BorderSide(color: Styles.BORDER_COLOR, width: 1),
        ),
      ),
      child: InkWell(
        onTap: () =>
            CustomNavigator.push(Routes.ITEM_DETAILS, arguments: item?.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item?.name ?? "",
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 14, color: Styles.TITLE),
            ),
            SizedBox(height: 6.h),
            Text(
              item?.address ?? "",
              style: AppTextStyles.medium
                  .copyWith(fontSize: 12, color: Styles.DETAILS_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
