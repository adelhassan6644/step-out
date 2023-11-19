import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/images.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_button.dart';
import 'package:stepOut/components/custom_images.dart';
import 'package:stepOut/components/custom_loading.dart';
import 'package:stepOut/features/profile/widgets/profile_image_widget.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../more/widgets/more_button.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("profile", context),
      ),
      body: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return provider.isLoading
            ? const Center(child: CustomLoading())
            : Column(
                children: [
                  Expanded(
                      child: ListAnimator(
                    data: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: 40.h),
                        child: const ProfileImageWidget(
                          withEdit: true,
                          radius: 60,
                        ),
                      ),
                      const ProfileBody(),
                      SizedBox(height: 24.h),
                      MoreButton(
                        title: getTranslated("change_password", context),
                        icon: SvgImages.lockIcon,
                        onTap: () =>
                            CustomNavigator.push(Routes.CHANGE_PASSWORD),
                      ),
                      MoreButton(
                        title: getTranslated("remove_acc", context),
                        icon: SvgImages.trash,
                        withBottomBorder: true,
                        onTap: () => CustomBottomSheet.show(
                          height: 450,
                          list: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                Text(
                                  getTranslated(
                                      "are_you_sure_remove_account", context),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 16, color: Styles.TITLE),
                                ),
                                SizedBox(height: 16.h),
                                customImageIcon(
                                    imageName: Images.removeAcc,
                                    height: 200,
                                    width: 200),
                              ],
                            ),
                          ),
                          label: getTranslated("remove_acc", context),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CustomButton(
                                      isLoading: provider.isDeleting,
                                      onTap: () => provider.deleteAcc(),
                                      text: getTranslated("remove", context))),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: CustomButton(
                                      textColor: Styles.PRIMARY_COLOR,
                                      backgroundColor:
                                          Styles.PRIMARY_COLOR.withOpacity(0.2),
                                      text: getTranslated("cancel", context))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              );
      }),
    );
  }
}
