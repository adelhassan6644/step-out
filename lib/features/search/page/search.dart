import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../widgets/search_body.dart';
import '../widgets/search_header.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          ///Search widget
          SearchHeader(),
          SearchBody(),
        ],
      ),
    );
  }
}
