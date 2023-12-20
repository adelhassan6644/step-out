import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';
import '../../../main_models/service_model.dart';

class ItemSubServicesWidget extends StatelessWidget {
  const ItemSubServicesWidget({super.key, this.service});

  final ServiceModel? service;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Text(
            getTranslated("sub_services", context),
            style: AppTextStyles.semiBold.copyWith(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                color: Styles.TITLE),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
                service?.subServices?.length ?? 0,
                (i) => SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomNetworkImage.circleNewWorkImage(
                              radius: 30,
                              image: service?.subServices?[i].image ?? ""),
                          const SizedBox(height: 4),
                          Text(
                            service?.subServices?[i].name ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: AppTextStyles.medium
                                .copyWith(fontSize: 14, color: Styles.TITLE),
                          ),
                        ],
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
