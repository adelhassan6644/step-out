import 'package:flutter/material.dart';
import 'package:stepOut/features/more/page/more.dart';
import 'package:stepOut/features/news/provider/news_provider.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:stepOut/main_page/provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../../data/config/di.dart';
import '../../data/network/netwok_info.dart';
import '../../features/home/page/home.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/page/map_page.dart';
import '../../features/news/page/news.dart';
import '../widget/nav_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    initData();
    NetworkInfo.checkConnectivity(onVisible: initData);
    super.initState();
  }

  initData() {
    Future.delayed(Duration.zero, () {
      sl<HomeProvider>().getBanners();
      sl<HomeProvider>().getCategories();
      sl<HomeProvider>().getOffers();
      sl<NewsProvider>().getNews();
      sl<ProfileProvider>().getProfile();
    });
  }

  Widget fragment(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const News();
      case 2:
        return const MapPage();
      case 3:
        return const More();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        bottomNavigationBar: const NavBar(),
        body: fragment(provider.selectedIndex),
      );
    });
  }
}
