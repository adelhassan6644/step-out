import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/config/di.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_header.dart';
import '../widgets/home_offers.dart';
import '../widgets/home_banners.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: RefreshIndicator(
              color: Styles.PRIMARY_COLOR,
              onRefresh: () async {
                sl<HomeProvider>().getBanners();
                sl<HomeProvider>().getCategories();
                sl<HomeProvider>().getOffers();
              },
              child: const ListAnimator(
                data: [
                  HomeBanner(),
                  HomeOffers(),
                  HomeCategories(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
