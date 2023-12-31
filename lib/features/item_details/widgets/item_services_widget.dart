import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/custom_bottom_sheet.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/item_details/provider/item_details_provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import 'item_sub_services_widget.dart';

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
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.TITLE),
            ),
          ),

          ///Services
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 12.w),
                ...List.generate(
                  provider.model?.services?.length ?? 0,
                  (index) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: SizedBox(
                        width: 70,
                        child: InkWell(
                          onTap: () {
                            if ((provider.model?.services?[index].subServices
                                        ?.length ??
                                    0) >
                                0) {
                              CustomBottomSheet.show(
                                label:
                                    provider.model?.services?[index].name ?? "",
                                list: ItemSubServicesWidget(
                                  service: provider.model?.services?[index],
                                ),
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomNetworkImage.circleNewWorkImage(
                                  radius: 30,
                                  image:
                                      provider.model?.services?[index].image ??
                                          ""),
                              const SizedBox(height: 4),
                              Text(
                                provider.model?.services?[index].name ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14, color: Styles.TITLE),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .scale(duration: 500.ms)
                            .then(delay: 250.ms) // baseline=800ms
                            .slide()
                            .scaleXY(duration: 500.ms)
                            .then(delay: 200.ms)
                            .shimmer(duration: 500.ms)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
