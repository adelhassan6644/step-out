import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeOffers extends StatelessWidget {
  const HomeOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Visibility(
        visible: provider.isGetOffers ||
            (provider.offersModel != null &&
                provider.offersModel?.data != null &&
                provider.offersModel!.data!.isNotEmpty),
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
            provider.isGetOffers
                ? const _OfferShimmer()
                : provider.offersModel != null &&
                        provider.offersModel?.data != null &&
                        provider.offersModel!.data!.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT.w),
                            ...List.generate(
                                provider.offersModel?.data?.length ?? 0,
                                (index) => InkWell(
                                      onTap: () => CustomNavigator.push(
                                          Routes.ITEM_DETAILS,
                                          arguments: provider.offersModel
                                              ?.data?[index].placeId),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: CustomNetworkImage
                                            .containerNewWorkImage(
                                          image: provider.offersModel
                                                  ?.data?[index].image ??
                                              "",
                                          height: 140.h,
                                          width: context.width * 0.7,
                                          fit: BoxFit.cover,
                                          radius: 20,
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      )
                    : EmptyState(
                        emptyHeight: 140.h,
                        withImage: false,
                      ),
          ],
        ),
      );
    });
  }
}

class _OfferShimmer extends StatelessWidget {
  const _OfferShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
          ...List.generate(
              6,
              (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL.w),
                    child: CustomShimmerContainer(
                      height: 140.h,
                      width: context.width * 0.7,
                    ),
                  ))
        ],
      ),
    );
  }
}
