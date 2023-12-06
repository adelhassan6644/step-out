import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_button.dart';
import '../provider/item_details_provider.dart';
import '../provider/send_rate_provider.dart';
import 'feedback_card.dart';
import 'send_rate_bottom_sheet.dart';

class ItemDetailsFeedback extends StatelessWidget {
  const ItemDetailsFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
        return Column(
          children: [
            Expanded(
              child: ListAnimator(
                customPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                data: provider.model?.feedbacks == null ||
                        provider.model!.feedbacks!.isEmpty
                    ? [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 40.h,
                          ),
                          child: EmptyState(

                            txt:
                                getTranslated("there_is_no_feedbacks", context),
                            subText:
                                getTranslated("give_us_your_feedback", context),
                          ),
                        )
                      ]
                    : List.generate(
                        provider.model?.feedbacks?.length ?? 0,
                        (index) => Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 16.h : 0),
                              child: FeedbackCard(
                                item: provider.model?.feedbacks?[index],
                              ),
                            )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Consumer<RattingProvider>(
                  builder: (context, sProvider, child) {
                return CustomButton(
                  text: getTranslated(
                      sProvider.isLogin ? "rate" : "login_before_rate",
                      context),
                  onTap: () {
                    if (sProvider.isLogin) {
                      CustomBottomSheet.show(
                        height: 500.h,
                        label: getTranslated("rate", context),
                        list: const SendRateBottomSheet(),
                        onConfirm: () {
                          sProvider.formKey.currentState!.validate();
                          if (Validations.feedBack(
                                  sProvider.feedback.value?.trim()) ==
                              null) {
                            sProvider.sendFeedback(
                              model: provider.model,
                              onChange: provider.updateModel,
                            );
                          }
                        },
                        onClose: () => sProvider.clear(),
                      );
                    } else {
                      CustomNavigator.push(Routes.LOGIN, arguments: true);
                    }
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
