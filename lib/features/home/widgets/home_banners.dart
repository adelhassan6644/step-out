import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            provider.isGetBanners
                ? const _BannerShimmer()
                : provider.bannerModel != null &&
                        provider.bannerModel?.data != null &&
                        provider.bannerModel!.data!.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              height: context.height * 0.275,
                              disableCenter: true,
                              pageSnapping: true,
                              autoPlay: true,
                              aspectRatio: 1.0,
                              viewportFraction: 1.0,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                provider.setBannerIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.bannerModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return InkWell(
                                onTap: () {
                                  CustomNavigator.push(Routes.ITEM_DETAILS,
                                      arguments: provider.bannerModel
                                              ?.data?[index].itemId ??
                                          0);
                                },
                                child: CustomNetworkImage.containerNewWorkImage(
                                  image: provider
                                          .bannerModel?.data?[index].image ??
                                      "",
                                  height: context.height * 0.275,
                                  width: context.width,
                                  radius: 20,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            carouselController: provider.bannerController,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              provider.bannerModel?.data?.length ?? 0,
                              (index) => AnimatedContainer(
                                width: index == provider.bannerIndex ? 10 : 6,
                                height: index == provider.bannerIndex ? 10 : 6,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: index == provider.bannerIndex
                                      ? Styles.PRIMARY_COLOR
                                      : Styles.ACCENT_COLOR,
                                  borderRadius: BorderRadius.circular(100.w),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : EmptyState(
                        emptyHeight: context.height * 0.3,
                      ),
          ],
        ),
      );
    });
  }
}

class _BannerShimmer extends StatelessWidget {
  const _BannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomShimmerContainer(
          height: context.height * 0.275,
          width: context.width,
          radius: 20,
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              4,
              (index) => Container(
                    width: index == 2 ? 10 : 6,
                    height: index == 2 ? 10 : 6,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: index == 2
                          ? Styles.PRIMARY_COLOR
                          : Styles.ACCENT_COLOR,
                      borderRadius: BorderRadius.circular(100.w),
                    ),
                  )),
        ),
      ],
    );
  }
}
