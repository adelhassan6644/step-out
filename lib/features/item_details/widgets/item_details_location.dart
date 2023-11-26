import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/features/maps/models/location_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../main_widgets/map_widget.dart';

class ItemDetailsLocation extends StatelessWidget {
  const ItemDetailsLocation({super.key, this.lat, this.long, this.address});
  final dynamic lat, long;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: InkWell(
            onTap: () async {
              await launch(
                  'https://www.google.com/maps/search/?api=1&query=$lat,$long');
            },
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
        ),
      ],
    );
  }
}
