import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';
import 'package:stepOut/features/category_details/widgets/subcategory_selection_bar.dart';
import '../../home/models/categories_model.dart';
import 'services_selction_bar.dart';

class CategoryDetailsHeader extends StatelessWidget {
  const CategoryDetailsHeader({super.key, required this.subCategories});
  final List<SubCategoryModel> subCategories;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SubcategorySelectionBar(subCategories: subCategories),
          const ServicesSelectionBar(),
        ],
      );
    });
  }
}
