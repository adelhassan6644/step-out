import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    currentIndex = pageController.page!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.WHITE_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () =>
                    CustomNavigator.push(Routes.DASHBOARD, clean: true),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      Text(
                        getTranslated("skip", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            onPageChanged: ((index) => setState(() {
                                  currentIndex = index;
                                })),
                            itemBuilder: (_, i) => ListAnimator(
                              data: [
                                SizedBox(
                                  height: context.height * 0.1,
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40.h,
                                      horizontal: context.width * 0.1),
                                  child: customImageIcon(
                                      imageName: Images.onBoarding1,
                                      height: 180,
                                      width: context.width),
                                ),

                                ///header
                                Text(
                                  getTranslated(
                                      i == 0
                                          ? "on_boarding_header_1"
                                          : "on_boarding_header_2",
                                      context),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 24,
                                      color: Styles.PRIMARY_COLOR),
                                ),

                                SizedBox(
                                  height: 12.h,
                                ),

                                ///description
                                Text(
                                  getTranslated(
                                      i == 0
                                          ? "on_boarding_description_1"
                                          : "on_boarding_description_2",
                                      context),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 14, color: Styles.ACCENT_COLOR),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        2,
                        (index) => AnimatedContainer(
                              width: index == currentIndex ? 10 : 6,
                              height: index == currentIndex ? 10 : 6,
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: index == currentIndex
                                    ? Styles.PRIMARY_COLOR
                                    : Styles.ACCENT_COLOR,
                                borderRadius: BorderRadius.circular(100.w),
                              ),
                            ))),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: CustomButton(
            text: getTranslated(currentIndex == 0 ? "next" : "start", context),
            onTap: () {
              if (currentIndex == 0) {
                setState(() {
                  nextPage();
                });
              } else {
                CustomNavigator.push(Routes.DASHBOARD, clean: true);
              }
            },
          ),
        ),
      ),
    );
  }
}
