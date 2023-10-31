import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../provider/category_details_provider.dart';

class ServicesSelectionBar extends StatelessWidget {
  const ServicesSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryDetailsProvider>(builder: (_, provider, child) {
      return AnimatedCrossFade(
        crossFadeState: provider.goingDown
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 800),
        firstChild: SizedBox(width: context.width),
        secondChild: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 18.h),
                  ...List.generate(
                    provider.filters.length,
                    (index) {
                      provider.servicesKeys
                          .add(GlobalKey(debugLabel: "$index"));
                      Future.delayed(const Duration(seconds: 1), () {
                        provider.animatedScrollServices(provider
                            .servicesKeys[provider.selectedFilter]
                            .currentContext??context);
                      });
                      return InkWell(
                        key: provider.servicesKeys[index],
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => provider.onSelectFilter(index),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: index == provider.selectedFilter
                                  ? Styles.PRIMARY_COLOR
                                  : Styles.PRIMARY_COLOR.withOpacity(0.1)),
                          child: Text(
                            provider.filters[index],
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                color: index == provider.selectedFilter
                                    ? Styles.WHITE_COLOR
                                    : Styles.PRIMARY_COLOR),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
