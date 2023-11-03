import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../provider/setting_provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("about_us", context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<SettingProvider>(builder: (_, provider, child) {
              return provider.isLoading
                  ? const CustomLoading()
                  : ListAnimator(
                      customPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      data: [
                        Visibility(
                          visible: provider.model != null,
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  Images.splash,
                                  width: context.width * 0.3,
                                  height: context.height * 0.23,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Dimensions.PADDING_SIZE_DEFAULT.h),
                                child: Text(
                                  getTranslated("about_step_out", context),
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 18, color: Styles.TITLE),
                                ),
                              ),
                            ],
                          ),
                        ),
                        provider.model != null
                            ? HtmlWidget(
                                provider.model?.data?.aboutUs ?? "About Us")
                            : EmptyState(
                                txt: getTranslated(
                                    "something_went_wrong", context),
                              ),
                        SizedBox(height: 24.h),
                      ],
                    );
            }),
          ),
        ],
      ),
    );
  }
}
