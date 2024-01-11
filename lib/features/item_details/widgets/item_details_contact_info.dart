import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../model/item_details_model.dart';

class ItemDetailsContactInfo extends StatelessWidget {
  const ItemDetailsContactInfo({super.key, this.phone, this.tags, this.times, this.notes});

  final String? phone,notes;
  final List<SubCategoryModel>? tags;
  final List<TimeModel>? times;

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
                child: InkWell(
                  onTap: () => launchUrl(Uri.parse("tel://$phone"),
                      mode: LaunchMode.externalApplication),
                  child: Text(
                    phone ?? "",
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.TITLE),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: (times?.length ?? 0) > 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.clock, width: 20, height: 20),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Wrap(
                      runSpacing: 4,
                      spacing: 8,
                      children: List.generate(
                          times?.length ?? 0,
                          (index)
                          {

                            if(times?[index].openingTime==times?[index].closingTime) {
                              return Text(
                                getTranslated("always_opening", context),
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    color: Styles.TITLE),
                                maxLines: 1,
                              );
                            }
                            return    Text(
                                  "(${Methods.convertStringToTime(times?[index].openingTime, withFormat: true)} - ${Methods.convertStringToTime(times?[index].closingTime, withFormat: true)})",
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: Styles.TITLE),
                                  maxLines: 1,
                                );
                              }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Wrap(
            runSpacing: 8.h,
            spacing: 8.w,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
                tags?.length ?? 0,
                (index) => InkWell(
                      onTap: () => CustomNavigator.push(Routes.HASHTAG_PLACES,
                          arguments: tags?[index]),
                      child: Text(
                        "#${tags?[index].name.toString().toUpperCase() ?? ""}",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.PRIMARY_COLOR),
                      ),
                    )),
          ),
          if(notes!=null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.notes,
                  color: Styles.PRIMARY_COLOR,
                  width: 20, height: 20),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  notes ?? "",
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      color: Styles.TITLE),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
