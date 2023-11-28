import 'package:flutter/material.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../provider/search_provider.dart';
import '../widgets/search_body.dart';
import '../widgets/search_header.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => sl<SearchProvider>().init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("search", context),
      ),
      body: const Column(
        children: [
          SearchHeader(),
          SearchBody(),
        ],
      ),
    );
  }
}
