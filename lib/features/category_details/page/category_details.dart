import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';
import 'package:stepOut/features/category_details/widgets/category_details_body.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../widgets/category_details_header.dart';
import '../widgets/subcategories_app_bar.dart';

class CategoryDetails extends StatefulWidget {
  final CategoryItem item;
  const CategoryDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<CategoryDetailsProvider>().getCategoryDetails(widget.item.id);
      sl<CategoryDetailsProvider>().scroll(controller);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      appBar: SubcategoriesAppBar(
        title: widget.item.title ?? "Restaurants",
      ),
      body: Column(
        children: [
          const CategoryDetailsHeader(),
          CategoryDetailsBody(id: widget.item.id ?? 0, controller: controller),
        ],
      ),
    );
  }
}
