import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/category_details/provider/category_details_provider.dart';
import 'package:stepOut/features/category_details/widgets/category_details_body.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_loading.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../widgets/category_details_header.dart';

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
      appBar: CustomAppBar(
        title: widget.item.name ?? "Restaurants",
        actionChild: customImageIconSVG(
          imageName: SvgImages.search,
          onTap: () => CustomNavigator.push(Routes.SEARCH),
        ),
        actionWidth: 25,
      ),
      body: Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
        return provider.isLoading
            ? const CustomLoading()
            : Column(
                children: [
                  CategoryDetailsHeader(
                      subCategories: widget.item.subCategories ?? []),
                  CategoryDetailsBody(
                      id: widget.item.id ?? 0, controller: controller),
                ],
              );
      }),
    );
  }
}
