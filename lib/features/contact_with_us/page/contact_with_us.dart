import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/features/setting/provider/setting_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("contact_with_us", context)),
      body: Column(
        children: [
          Expanded(
              child: Consumer<SettingProvider>(builder: (_, provider, child) {
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
                              provider.model?.data?.email ??
                                  "StepOut@gmail.com",
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
                              provider.model?.data?.phone ?? "12345",
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
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: [
                    ///Facebook
                    if (provider.model?.data?.facebook != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.faceBook,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.facebook!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),

                    ///Instagram
                    if (provider.model?.data?.instagram != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.instagram,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.instagram!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),

                    ///Twitter
                    if (provider.model?.data?.twitter != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.twitter,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.twitter!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),

                    ///Tiktok
                    if (provider.model?.data?.tiktok != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.tiktok,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.tiktok!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),

                    ///WhatsApp
                    if ((provider.model?.data?.whatsApp != null))
                      customContainerSvgIcon(
                          imageName: SvgImages.whatsApp,
                          color: Styles.PRIMARY_COLOR,
                          height: 40,
                          width: 40,
                          radius: 100,
                          onTap: () async {
                            await launch(
                                "whatsapp://send?phone=${provider.model?.data?.whatsApp}");
                          }),

                    ///SnapChat
                    if (provider.model?.data?.snapchat != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.snapchat,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.snapchat!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),

                    ///Website
                    if (provider.model?.data?.website != null)
                      customContainerSvgIcon(
                        imageName: SvgImages.global,
                        color: Styles.PRIMARY_COLOR,
                        height: 40,
                        width: 40,
                        radius: 100,
                        onTap: () async {
                          launchUrl(Uri.parse(provider.model!.data!.website!),
                              mode: LaunchMode.externalApplication);
                        },
                      ),
                  ],
                ),
              ],
            );
          }))
        ],
      ),
    );
  }
}
