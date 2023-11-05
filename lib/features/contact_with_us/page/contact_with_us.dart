import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/components/animated_widget.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../provider/contact_provider.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("contact_with_us", context)),
      body: Column(
        children: [
          Expanded(
              child: Consumer<ContactProvider>(builder: (_, provider, child) {
            return ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 24.h),
              data: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.1,
                  ),
                  child: customImageIcon(
                    imageName: Images.contactWithUsBG,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  decoration: const BoxDecoration(
                      color: Styles.WHITE_COLOR,
                      border: Border(
                          top: BorderSide(color: Styles.BORDER_COLOR),
                          bottom: BorderSide(color: Styles.BORDER_COLOR))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          customImageIconSVG(
                              imageName: SvgImages.supportCall,
                              width: 24,
                              height: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              getTranslated("technical_support_team", context),
                              style: AppTextStyles.medium.copyWith(
                                  color: Styles.PRIMARY_COLOR,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///E-mail
                            Text(
                              getTranslated("mail", context),
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14, color: Styles.HINT_COLOR),
                            ),
                            Text(
                              provider.contactModel?.email ?? "Step Out",
                              style: AppTextStyles.medium
                                  .copyWith(fontSize: 14, color: Styles.TITLE),
                            ),
                            Divider(
                              color: Styles.BORDER_COLOR,
                              height: 24.h,
                            ),

                            ///Phone
                            Text(
                              getTranslated("phone", context),
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14, color: Styles.HINT_COLOR),
                            ),
                            Text(
                              provider.contactModel?.phone ?? "12345",
                              style: AppTextStyles.medium
                                  .copyWith(fontSize: 14, color: Styles.TITLE),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                  child: Text(
                    getTranslated("follow_us", context),
                    style: AppTextStyles.semiBold.copyWith(
                        color: Styles.PRIMARY_COLOR,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customContainerSvgIcon(
                      radius: 100,
                      width: 40,
                      height: 40,
                      imageName: SvgImages.instagram,
                      color: Styles.PRIMARY_COLOR,
                    ),
                    SizedBox(width: 16.w),
                    customContainerSvgIcon(
                      radius: 100,
                      width: 40,
                      height: 40,
                      imageName: SvgImages.faceBook,
                      color: Styles.PRIMARY_COLOR,
                    ),
                  ],
                )
              ],
            );
          }))
        ],
      ),
    );
  }
}
