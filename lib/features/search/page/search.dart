import 'package:flutter/material.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../widgets/search_body.dart';
import '../widgets/search_header.dart';

class Search extends StatelessWidget {
  const Search({super.key});

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
