import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    currentIndex = pageController.page!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: ((index) => setState(() {
                    currentIndex = index;
                  })),
              itemBuilder: (c, i) => ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 40.h, horizontal: context.width * 0.1),
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
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 24, color: Styles.PRIMARY_COLOR),
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
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 14, color: Styles.ACCENT_COLOR),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
