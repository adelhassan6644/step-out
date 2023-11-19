import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/custom_loading.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../provider/notifications_provider.dart';
import '../widgets/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero, () => sl<NotificationsProvider>().getNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(
        //   title: getTranslated("notifications", context),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
              ),
              child: Text(getTranslated("notifications", context),
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
            Expanded(
              child: Consumer<NotificationsProvider>(
                  builder: (_, provider, child) {
                return provider.isLoading
                    ? const CustomLoading()
                    : provider.model != null &&
                            provider.model?.data != null &&
                            provider.model!.data!.isNotEmpty
                        ? RefreshIndicator(
                            color: Styles.PRIMARY_COLOR,
                            onRefresh: () async {
                              provider.getNotifications();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListAnimator(
                                      data: List.generate(
                                          provider.model?.data?.length ?? 5,
                                          (index) => Dismissible(
                                                background: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      width: 100.w,
                                                      height: 30.h,
                                                      text: getTranslated(
                                                          "delete", context),
                                                      svgIcon: SvgImages.trash,
                                                      iconSize: 12,
                                                      iconColor:
                                                          Styles.IN_ACTIVE,
                                                      textColor:
                                                          Styles.IN_ACTIVE,
                                                      backgroundColor: Styles
                                                          .IN_ACTIVE
                                                          .withOpacity(0.12),
                                                    ),
                                                  ],
                                                ),
                                                key: ValueKey(index),
                                                confirmDismiss:
                                                    (DismissDirection
                                                        direction) async {
                                                  provider.deleteNotification(
                                                      provider
                                                              .model
                                                              ?.data?[index]
                                                              .id ??
                                                          0);
                                                  return false;
                                                },
                                                child: NotificationCard(
                                                  withBorder: index != 9,
                                                  notification: provider
                                                      .model?.data?[index],
                                                ),
                                              ))),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            color: Styles.PRIMARY_COLOR,
                            onRefresh: () async {
                              provider.getNotifications();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListAnimator(
                                      customPadding: EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_DEFAULT.w),
                                      data: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: context.height * 0.17),
                                          child: EmptyState(
                                            txt: getTranslated(
                                                "no_notifications", context),
                                            imgHeight: 250,
                                            imgWidth: 250,
                                            spaceBtw: 50,
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          );
              }),
            )
          ],
        ),
      ),
    );
  }
}
