import 'package:stepOut/app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import '../../app/core/utils/text_styles.dart';

class CheckBoxListTile extends StatelessWidget {
  const CheckBoxListTile({
    Key? key,
    this.check = false,
    required this.title,
    this.description,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final String title;
  final String? description;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(!check),
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Styles.WHITE_COLOR,
                border: Border.all(
                    color: check
                        ? Styles.ACCENT_COLOR
                        : Styles.DISABLED,
                    width: 1)),
            child: check
                ? const Icon(
                    Icons.check,
                    color: Styles.ACCENT_COLOR,
                    size: 14,
                  )
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: check
                      ? Styles.ACCENT_COLOR
                      : Styles.DISABLED),
            ),
          ),
          if (description != null)
            Text(
              description!,
              style: AppTextStyles.bold.copyWith(
                  fontSize: 10,
                  color: check
                      ? Styles.ACCENT_COLOR
                      : Styles.SUBTITLE),
            )
        ],
      ),
    );
  }
}
