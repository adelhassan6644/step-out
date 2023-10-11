import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/color_resources.dart';
import 'package:stepOut/app/core/utils/svg_images.dart';
import 'package:stepOut/app/localization/localization/language_constant.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../auth/provider/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  final Function() onTap;
  const LogoutButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(100),
            color: ColorResources.WHITE_COLOR),
        child: InkWell(
          onTap: () {
            onTap();
            if (provider.isLogin) {
              sl<AuthProvider>().logOut();
            } else {
              CustomNavigator.push(Routes.LOGIN, arguments: true);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.logout,
                  height: 20,
                  width: 20,
                  color: provider.isLogin
                      ? ColorResources.ERORR_COLOR
                      : ColorResources.ACTIVE),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          getTranslated(
                              provider.isLogin ? "logout" : "login", context),
                          maxLines: 1,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: provider.isLogin
                                  ? ColorResources.ERORR_COLOR
                                  : ColorResources.ACTIVE)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
