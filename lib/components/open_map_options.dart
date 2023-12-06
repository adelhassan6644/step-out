import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/components/custom_images.dart';

import '../app/core/utils/dimensions.dart';
import '../app/core/utils/styles.dart';

class OpenMapOption extends StatelessWidget {
  const OpenMapOption({super.key, required this.maps, this.onMapTap});
  final List<AvailableMap> maps;
  final Function(AvailableMap map)? onMapTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        maps.length,
        (index) => InkWell(
          onTap: () => onMapTap!(maps[index]),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Styles.BORDER_COLOR,
              ),
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: customCircleSvgIcon(
                    imageName: maps[index].icon,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Text(
                    maps[index].mapName,
                    style: AppTextStyles.semiBold
                        .copyWith(color: Styles.HEADER, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
