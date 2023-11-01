import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/main_widgets/item_card.dart';
import 'package:provider/provider.dart';

import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/location_provider.dart';

class MapPlaces extends StatelessWidget {
  const MapPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Consumer<LocationProvider>(builder: (_, provider, child) {
        return provider.isGetPlaces
            ? SizedBox(
                height: 232.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) => CustomShimmerContainer(
                                height: 220.h,
                                width: 210.w,
                              ),
                          separatorBuilder: (_, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount: 5),
                    ),
                  ],
                ),
              )
            : provider.model != null &&
                    provider.model != null &&
                    provider.model!.isNotEmpty
                ? SizedBox(
                    height: 232.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (_, index) =>
                                  // ItemCard(place: provider.model![index]),
                                  const ItemCard(),
                              separatorBuilder: (_, index) => SizedBox(
                                    width: 12.w,
                                  ),
                              itemCount: provider.model!.length),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
      }),
    );
  }
}
