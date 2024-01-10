import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/features/item_details/repo/item_details_repo.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../data/config/di.dart';
import '../provider/item_details_provider.dart';
import '../widgets/item_details_body.dart';

class ItemDetails extends StatelessWidget {
  final int id;

  const ItemDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ItemDetailsProvider(repo: sl<ItemDetailsRepo>())..getDetails(id),
      child: Consumer<ItemDetailsProvider>(builder: (context, provider, child) {
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
                            InkWell(
                              onTap: () {
                                Future.delayed(
                                    Duration.zero,
                                    () => showDialog(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.75),
                                        builder: (context) {
                                          return ImagePopUpViewer(
                                            image: provider.model?.cover,
                                            isFromInternet: true,
                                            title: "",
                                          );
                                        }));
                              },
                              child: CustomNetworkImage.containerNewWorkImage(
                                  image: provider.model?.cover ?? "",
                                  imageWidget: Column(
                                    children: [
                                      CustomAppBar(
                                        withSafeArea: true,
                                        backColor: Styles.WHITE_COLOR,
                                        actionWidth: 22,
                                        actionChild: customImageIconSVG(
                                          imageName: SvgImages.export,
                                          color: Styles.WHITE_COLOR,
                                          onTap: () => provider.sharePlace(),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox())
                                    ],
                                  ),
                                  height: 240.h,
                                  width: context.width,

                                  radius: 0),
                            ),
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
      }),
    );
  }
}
