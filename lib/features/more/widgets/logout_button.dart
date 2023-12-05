import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../auth/provider/auth_provider.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, provider, child) {
      return InkWell(
        onTap: () {
          if (provider.isLogin) {
            provider.logOut();
          } else {
            CustomNavigator.push(Routes.LOGIN, arguments: true);
          }
        },
        child: Container(
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
                  imageName: SvgImages.logout,
                  height: 20,
                  width: 20,
                  color: provider.isLogin ? Styles.ERORR_COLOR : Styles.ACTIVE),
              const SizedBox(
                width: 16,
              ),
              provider.isLogOut
                  ? const SpinKitThreeBounce(
                      color: Styles.ERORR_COLOR,
                      size: 25,
                    )
                  : Expanded(
                      child: Text(
                          getTranslated(
                              provider.isLogin ? "logout" : "login", context),
                          maxLines: 1,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: provider.isLogin
                                  ? Styles.ERORR_COLOR
                                  : Styles.ACTIVE)),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
