import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/home/models/offers_model.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/image_pop_up_viewer.dart';

class ItemDetailsOffer extends StatelessWidget {
  const ItemDetailsOffer({super.key, this.offers});
  final List<OfferItem>? offers;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: offers != null && offers!.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              getTranslated("offers", context),
              style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.TITLE),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.w),
                ...List.generate(
                  offers?.length ?? 0,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    child: InkWell(
                      onTap: () {
                        Future.delayed(
                            Duration.zero,
                            () => showDialog(
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.75),
                                builder: (context) {
                                  return ImagePopUpViewer(
                                    image: offers?[index].image ?? "",
                                    isFromInternet: true,
                                    title: "",
                                  );
                                }));
                      },
                      child: CustomNetworkImage.containerNewWorkImage(
                          height: 100.h,
                          width: context.width * 0.7,
                          radius: 20,
                          image: offers?[index].image ?? ""),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
