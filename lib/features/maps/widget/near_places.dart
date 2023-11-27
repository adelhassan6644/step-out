import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/main_widgets/item_card.dart';
import 'package:provider/provider.dart';

import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/location_provider.dart';

class NearPlaces extends StatelessWidget {
  const NearPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Consumer<LocationProvider>(builder: (_, provider, child) {
        return provider.isGetPlaces
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10.w),
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CustomShimmerContainer(
                          height: 220.h,
                          width: context.width * 0.85,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : provider.model != null && provider.model!.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        ...List.generate(
                            provider.model?.length ?? 0,
                            (index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: ItemCard(
                                    width: context.width * 0.85,
                                    item: provider.model?[index],
                                  ),
                                ))
                      ],
                    ),
                  )
                : const SizedBox();
      }),
    );
  }
}
