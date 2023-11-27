import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../provider/item_details_provider.dart';
import '../widgets/item_details_body.dart';

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
    return Consumer<ItemDetailsProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        appBar: provider.isLoading ||
                (provider.model == null && !provider.isLoading)
            ? const CustomAppBar()
            : null,
        body: provider.isLoading
            ? const CustomLoading()
            : provider.model != null
                ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          CustomNetworkImage.containerNewWorkImage(
                              image: provider.model?.cover ?? "",
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
                : EmptyState(
                    txt: getTranslated("something_went_wrong", context),
                  ),
      );
    });
  }
}
