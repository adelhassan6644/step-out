import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/features/hashtag_places/provider/hashtag_places_provider.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/item_card.dart';
import '../provider/new_places_provider.dart';

class NewPlaces extends StatefulWidget {
  const NewPlaces({
    Key? key,
  }) : super(key: key);

  @override
  State<NewPlaces> createState() => _NewPlacesState();
}

class _NewPlacesState extends State<NewPlaces> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewPlacesProvider>(
      builder: (context, provider, child) {
        return Visibility(
            visible: provider.isLoading ||
                (provider.model != null && provider.model!.isNotEmpty),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  child: Text(
                    getTranslated("new_on_the_app", context),
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 22, color: Styles.HEADER),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                provider.isLoading
                    ? SizedBox(
                  height: 140.h,
                      child: ListAnimator(
                        direction: Axis.horizontal,
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
                        ),
                    )
                    : SizedBox(
                  height: 310,
                      child: ListAnimator(
                          direction: Axis.horizontal,

                          customPadding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          data: List.generate(
                            provider.model?.length ?? 0,

                            (int index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
                              ),
                              child: SizedBox(
                                  width: context.width*.75,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ItemCard(item: provider.model?[index]),
                                  )),
                            ),
                          ),
                        ),
                    )
              ],
            ));
      },
    );
  }
}
