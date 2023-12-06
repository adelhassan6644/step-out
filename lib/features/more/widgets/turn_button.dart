import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class TurnButton extends StatelessWidget {
  const TurnButton({
    required this.title,
    this.onTap,
    Key? key,
    required this.icon,
    required this.bing,
  }) : super(key: key);
  final String title, icon;
  final bool bing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL.h,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Styles.BORDER_COLOR,
        ),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
              imageName: icon, height: 24, width: 24, color: Styles.TITLE),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(title,
                  maxLines: 1,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: Styles.TITLE)),
            ),
          ),
          SizedBox(
            height: 10,
            child: Switch(
              value: bing,
              inactiveThumbColor: Styles.WHITE_COLOR,
              inactiveTrackColor: Styles.BORDER_COLOR,
              onChanged: (v) {
                onTap!();
              },
              trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return bing ? Styles.PRIMARY_COLOR : Styles.BORDER_COLOR;
              }),
              trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
                  (Set<MaterialState> states) {
                return 1.0;
              }),
            ),
          )
        ],
      ),
    );
  }
}
