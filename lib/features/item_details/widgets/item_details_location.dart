import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/custom_bottom_sheet.dart';
import 'package:stepOut/features/maps/models/location_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../components/open_map_options.dart';

class ItemDetailsLocation extends StatelessWidget {
  const ItemDetailsLocation(
      {super.key, this.lat, this.long, this.address, this.itemName});
  final dynamic lat, long;
  final String? address, itemName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final List<AvailableMap> availableMaps =
            await MapLauncher.installedMaps;
        CustomBottomSheet.show(
          height: 450.h,
          list: OpenMapOption(
            maps: availableMaps,
            onMapTap: (map) {
              CustomNavigator.pop();
              map.showMarker(
                coords: Coords(double.parse(lat!), double.parse(long!)),
                title: itemName ?? "",
              );
            },
          ),
          label: getTranslated("select_map", context),
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: MapWidget(
                point: LocationModel(latitude: lat, longitude: long),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.location, width: 20, height: 20),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      address ?? "",
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.TITLE),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
