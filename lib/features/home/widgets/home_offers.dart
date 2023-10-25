import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/localization/localization/language_constant.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeOffers extends StatelessWidget {
  const HomeOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            child: Text(
              getTranslated("offers", context),
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 22, color: Styles.HEADER),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Consumer<HomeProvider>(builder: (context, provider, child) {
            return !provider.isGetOffers
                ? const _OfferShimmer()
                : provider.offersModel != null &&
                        provider.offersModel?.data != null &&
                        provider.offersModel!.data!.isNotEmpty
                    ? SizedBox(
                        height: 140.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    ...List.generate(
                                        provider.categoriesModel?.data
                                                ?.length ??
                                            0,
                                        (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: CustomNetworkImage
                                                  .containerNewWorkImage(
                                                      image: provider
                                                              .offersModel
                                                              ?.data?[index]
                                                              .image ??
                                                          "",
                                                      height: 140.h,
                                                      width:
                                                          context.width * 0.7,
                                                      fit: BoxFit.cover,
                                                      radius: 20),
                                            ))
                                  ]),
                            ),
                          ],
                        ),
                      )
                    : EmptyState(
                        emptyHeight: 140.h,
                        imgHeight: 50,
                      );
          }),
        ],
      ),
    );
  }
}

class _OfferShimmer extends StatelessWidget {
  const _OfferShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    width: 6.w,
                  ),
                  ...List.generate(
                      4,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: CustomShimmerContainer(
                              height: 140.h,
                              width: context.width * 0.7,
                            ),
                          ))
                ]),
          ),
        ],
      ),
    );
  }
}
