import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../provider/news_provider.dart';
import '../widgets/news_card.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => sl<NewsProvider>().getNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                ),
                child: Text(getTranslated("news", context),
                    style: AppTextStyles.semiBold
                        .copyWith(fontSize: 24, color: Styles.HEADER)),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
                child: const Divider(
                  color: Styles.BORDER_COLOR,
                ),
              ),
              NewsCard(),
              Expanded(
                  child: provider.isLoading
                      ? ListAnimator(
                          customPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          ),
                          data: List.generate(
                              4,
                              (i) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL.h),
                                    child: CustomShimmerContainer(
                                      height: 220.h,
                                      radius: 20,
                                    ),
                                  )),
                        )
                      : provider.model != null &&
                              provider.model!.data != null &&
                              provider.model!.data!.isNotEmpty
                          ? RefreshIndicator(
                              color: Styles.PRIMARY_COLOR,
                              onRefresh: () async {
                                provider.getNews();
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListAnimator(
                                      data: List.generate(
                                          provider.model?.data?.length ?? 0,
                                          (i) => NewsCard(
                                                newsItem:
                                                    provider.model?.data?[i],
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              color: Styles.PRIMARY_COLOR,
                              onRefresh: () async {
                                provider.getNews();
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListAnimator(
                                      data: [
                                        EmptyState(
                                          imgWidth: 215.w,
                                          imgHeight: 220.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
            ],
          ),
        );
      },
    );
  }
}
