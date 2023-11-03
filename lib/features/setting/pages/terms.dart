import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../provider/setting_provider.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("terms_conditions", context),
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
                          child: Center(
                            child: Image.asset(
                              Images.splash,
                              width: context.width * 0.3,
                              height: context.height * 0.23,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.model != null
                            ? HtmlWidget(provider.model?.data?.terms ?? "Terms")
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
