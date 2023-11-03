import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
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
      child: Consumer<ItemDetailsProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: ListAnimator(
                customPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                data: [
                  SizedBox(height: 16.h),
                  ...List.generate(5, (index) => const FeedbackCard())
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Consumer<RattingProvider>(
                  builder: (context, provider, child) {
                return CustomButton(
                  text: getTranslated("rate", context),
                  onTap: () => CustomBottomSheet.show(
                      height: 500.h,
                      label: getTranslated("rate", context),
                      list: const SendRateBottomSheet(),
                      onConfirm: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider.sendFeedback(1);
                        }
                      },
                      onClose: () => provider.clear(),
                      isLoading: provider.isLoading),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
