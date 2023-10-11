import 'package:stepOut/app/core/utils/color_resources.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/config/di.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_header.dart';
import '../widgets/home_news.dart';
import '../widgets/home_offers.dart';
import '../widgets/home_banners.dart';
import '../widgets/home_places.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with AutomaticKeepAstepOutClientMixin<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<HomeProvider>().scroll(controller);
      sl<HomeProvider>().getBanners();
      sl<HomeProvider>().getPlaces();
      sl<HomeProvider>().getCategories();
      sl<HomeProvider>().getOffers();
      sl<HomeProvider>().getNews();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: RefreshIndicator(
              color: ColorResources.PRIMARY_COLOR,
              onRefresh: () async {
                // sl<HomeProvider>().show = false;
                sl<HomeProvider>().getPlaces();
                sl<HomeProvider>().getCategories();
                sl<HomeProvider>().getOffers();
                sl<HomeProvider>().getNews();
              },
              child: ListAnimator(
                controller: controller,
                data: const [
                  HomeBanner(),
                  HomeCategories(),
                  HomePlaces(),
                  HomeOffers(),
                  HomeNews(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAstepOut
  bool get wantKeepAstepOut => true;
}
