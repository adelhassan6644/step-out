import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import 'package:stepOut/components/custom_loading.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("news", context),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                //     vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                //   ),
                //   child: Text(getTranslated("news", context),
                //       style: AppTextStyles.semiBold
                //           .copyWith(fontSize: 24, color: Styles.HEADER)),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
                //   child: const Divider(
                //     color: Styles.BORDER_COLOR,
                //   ),
                // ),
                Expanded(
                  child: provider.isLoading
                      ? const CustomLoading()
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
                                      customPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w,
                                      ),
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
                                      customPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w,
                                      ),
                                      data: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: context.height * 0.25),
                                          child: EmptyState(
                                            imgWidth: 215.w,
                                            imgHeight: 220.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
