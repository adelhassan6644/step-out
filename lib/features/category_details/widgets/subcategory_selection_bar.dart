import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import '../../../components/tab_widget.dart';
import '../../home/models/categories_model.dart';
import '../provider/category_details_provider.dart';

class SubcategorySelectionBar extends StatelessWidget {
  const SubcategorySelectionBar({super.key, required this.subCategories});
  final List<SubCategoryModel> subCategories;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                subCategories.length,
                    (index) {
                  provider.subCategoriesKeys
                      .add(GlobalKey(debugLabel: "$index"));
                  Future.delayed(const Duration(seconds: 1), () {
                    provider.animatedScrollSubCategories(provider
                        .subCategoriesKeys[
                    provider.selectedSubCategoryIndex]
                        .currentContext ??
                        context);
                  });
                  return TabWidget(
                    key: provider.subCategoriesKeys[index],
                    label: subCategories[index].name ?? "",
                    isSelected: index == provider.selectedSubCategoryIndex,
                    onTap: () => provider.onSelectSubCategory(
                        index, subCategories[index].id),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
