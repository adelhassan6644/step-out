import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/features/language/provider/localization_provider.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../language/page/language_bottom_sheet.dart';
import 'logout_button.dart';
import 'more_button.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoreButton(
          title: getTranslated("profile", context),
          icon: SvgImages.userIcon,
          onTap: () => CustomNavigator.push(Routes.PROFILE),
        ),
        MoreButton(
          title: getTranslated("news", context),
          icon: SvgImages.newsIcon,
          onTap: () => CustomNavigator.push(Routes.NEWS),
        ),
        Consumer<LocalizationProvider>(builder: (_, provider, child) {
          return MoreButton(
            title: getTranslated("language", context),
            icon: SvgImages.language,
            onTap: () => CustomBottomSheet.show(
                height: 450,
                list: const LanguageBottomSheet(),
                label: getTranslated("select_language", context),
                onConfirm: () {
                  CustomNavigator.pop();
                  provider.setLanguage(
                    Locale(
                      AppStorageKey.languages[provider.selectIndex].languageCode!,
                      AppStorageKey.languages[provider.selectIndex].countryCode,
                    ),
                  );
                }),
          );
        }),
        MoreButton(
          title: getTranslated("contact_with_us", context),
          icon: SvgImages.contactWithUs,
          onTap: () => CustomNavigator.push(Routes.CONTACT_WITH_US),
        ),
        MoreButton(
          title: getTranslated("terms_conditions", context),
          icon: SvgImages.terms,
          onTap: () => CustomNavigator.push(Routes.TERMS),
        ),
        MoreButton(
          title: getTranslated("about_us", context),
          icon: SvgImages.aboutUs,
          onTap: () => CustomNavigator.push(Routes.ABOUT_US),
        ),
        const LogoutButton(),
      ],
    );
  }
}
