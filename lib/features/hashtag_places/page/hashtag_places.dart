import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/hashtag_places/provider/hashtag_places_provider.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/item_card.dart';

class HashtagPlaces extends StatefulWidget {
  final SubCategoryModel item;
  const HashtagPlaces({Key? key, required this.item}) : super(key: key);

  @override
  State<HashtagPlaces> createState() => _HashtagPlacesState();
}

class _HashtagPlacesState extends State<HashtagPlaces> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<HashtagPlacesProvider>().getPlaces(widget.item.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      appBar: CustomAppBar(
        title: "#${widget.item.name ?? ""}",
      ),
      body: Column(
        children: [
          Consumer<HashtagPlacesProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: provider.isLoading
                    ? ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        data: List.generate(
                          8,
                          (int index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                            ),
                            child: CustomShimmerContainer(
                              height: 200.h,
                              width: context.width,
                              radius: 20,
                            ),
                          ),
                        ),
                      )
                    : provider.model != null && provider.model!.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              provider.getPlaces(widget.item.id);
                            },
                            color: Styles.PRIMARY_COLOR,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListAnimator(
                                    customPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w),
                                    data: List.generate(
                                      provider.model?.length ?? 0,
                                      (int index) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              Dimensions.PADDING_SIZE_DEFAULT.h,
                                        ),
                                        child: ItemCard(
                                            item: provider.model?[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            color: Styles.PRIMARY_COLOR,
                            onRefresh: () async {
                              provider.getPlaces(widget.item.id);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListAnimator(
                                    customPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w),
                                    data: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: context.height * 0.125),
                                        child: EmptyState(
                                          imgWidth: 215.w,
                                          imgHeight: 220.h,
                                          spaceBtw: 12,
                                          txt: getTranslated(
                                              "there_is_no_data", context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
              );
            },
          )
        ],
      ),
    );
  }
}
