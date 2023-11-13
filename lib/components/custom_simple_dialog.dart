import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import '../../navigation/custom_navigation.dart';

abstract class CustomSimpleDialog {
  static parentSimpleDialog(
      {required List<Widget>? customListWidget, bool canDismiss = true}) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: SimpleDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
                  elevation: 1,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                  ),
                  children: customListWidget!,
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: canDismiss,
        barrierLabel: '',
        context: CustomNavigator.navigatorState.currentContext!,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
