import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../provider/item_details_provider.dart';
import '../widgets/item_details_body.dart';
import '../widgets/item_details_info.dart';

class ItemDetails extends StatefulWidget {
  final int id;

  const ItemDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<ItemDetailsProvider>().getDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      body: SafeArea(
        top: false,
        child:
            Consumer<ItemDetailsProvider>(builder: (context, provider, child) {
          return provider.isLoading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomNetworkImage.containerNewWorkImage(
                        image: "",
                        width: context.width,
                        height: context.height,
                        fit: BoxFit.fitWidth,
                        radius: 0),
                    const Column(
                      children: [
                        CustomAppBar(),
                        Expanded(child: SizedBox()),
                        PlaceDetailsWidgetShimmer(),
                      ],
                    ),
                  ],
                )
              : provider.model == null
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            CustomNetworkImage.containerNewWorkImage(
                                image: AppStrings.networkImage,
                                imageWidget: const Column(
                                  children: [
                                    CustomAppBar(
                                      withSafeArea: true,
                                      backColor: Styles.WHITE_COLOR,
                                    ),
                                    Expanded(child: SizedBox())
                                  ],
                                ),
                                height: 240.h,
                                width: context.width,
                                radius: 0),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 175.h),
                          child: const ItemDetailsBody(),
                        ),
                      ],
                    )
                  : const EmptyState(
                      emptyHeight: 200,
                      imgHeight: 110,
                    );
        }),
      ),
    );
  }
}