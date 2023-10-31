import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';
import 'package:stepOut/features/category_details/widgets/subcategory_selection_bar.dart';
import 'services_selction_bar.dart';

class CategoryDetailsHeader extends StatelessWidget {
  const CategoryDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return const Column(
        children: [
          SubcategorySelectionBar(),
          ServicesSelectionBar(),
        ],
      );
    });
  }
}
