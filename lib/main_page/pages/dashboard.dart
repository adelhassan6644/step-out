import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/features/profile/page/profile.dart';
import 'package:stepOut/main_page/provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../components/custom_images.dart';
import '../../data/config/di.dart';
import '../../data/network/netwok_info.dart';
import '../../features/favourite/page/favourites.dart';
import '../../features/home/page/home.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/page/map_page.dart';
import '../widget/nav_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key, required this.controller}) : super(key: key);
  final ZoomDrawerController controller;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    NetworkInfo.checkConnectivity(onVisible: () {
      sl<HomeProvider>().getBanners();
      sl<HomeProvider>().getPlaces();
      sl<HomeProvider>().getCategories();
      sl<HomeProvider>().getOffers();
      sl<HomeProvider>().getNews();
    });
    super.initState();
  }

  Widget fragment(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Profile();
      case 2:
        return const MapPage();
      case 3:
        return const Favourites();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: ColorResources.BACKGROUND_COLOR,
        bottomNavigationBar: NavBar(
          controller: widget.controller,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: provider.selectedIndex == 2
            ? FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {},
                backgroundColor: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: customImageIconSVG(
                    imageName: SvgImages.stepOutLocationIcon,
                  ),
                ),
              )
            : null,
        body: fragment(provider.selectedIndex),
      );
    });
  }
}
