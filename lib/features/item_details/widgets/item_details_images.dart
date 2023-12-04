import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/animated_widget.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../provider/item_details_provider.dart';

class ItemDetailsImages extends StatelessWidget {
  const ItemDetailsImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        customPadding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        data: [
          Consumer<ItemDetailsProvider>(builder: (context, provider, child) {
            return GridListAnimatorWidget(
              aspectRatio: 1.6,
              items: List.generate(
                provider.model?.images?.length ?? 0,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 2,
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () {
                            Future.delayed(
                                Duration.zero,
                                () => showDialog(
                                    context: context,
                                    barrierColor:
                                        Colors.black.withOpacity(0.75),
                                    builder: (context) {
                                      return ImagePopUpViewer(
                                        image: provider.model?.images?[index] ??
                                            "",
                                        isFromInternet: true,
                                        title: "",
                                      );
                                    }));
                          },
                          child: CustomNetworkImage.containerNewWorkImage(
                              radius: 20,
                              image: provider.model?.images?[index] ?? ""),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
