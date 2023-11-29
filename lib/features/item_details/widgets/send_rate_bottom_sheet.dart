import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/features/item_details/provider/send_rate_provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';

class SendRateBottomSheet extends StatefulWidget {
  const SendRateBottomSheet({super.key});

  @override
  State<SendRateBottomSheet> createState() => _SendRateBottomSheetState();
}

class _SendRateBottomSheetState extends State<SendRateBottomSheet> {
  final FocusNode feedbackNode = FocusNode();

  bool focusOnFeedback = false;

  @override
  void initState() {
    feedbackNode.addListener(() {
      focusOnFeedback = feedbackNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RattingProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
          child: Column(
            children: [
              ///Rate Count
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: GestureDetector(
                      onTap: () => provider.selectedRate(index),
                      child: customImageIconSVG(
                        height: 35,
                        width: 35,
                        color: provider.ratting < index
                            ? Styles.DETAILS_COLOR
                            : Colors.amber,
                        imageName: provider.ratting < index
                            ? SvgImages.emptyStar
                            : SvgImages.fillStar,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              ///Feedback
              StreamBuilder<String?>(
                  stream: provider.feedbackStream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      onChanged: provider.updateFeedback,
                      label: getTranslated("rate", context),
                      hint: getTranslated("enter_your_rate", context),
                      withLabel: true,
                      onTap: () {
                        setState(() => focusOnFeedback = !focusOnFeedback);
                        if (!focusOnFeedback) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      maxLines: 5,
                      minLines: 5,
                      height: 170,
                      onTapOutside: (v) =>
                          setState(() => focusOnFeedback = false),
                      focusNode: feedbackNode,
                      alignLabel: focusOnFeedback,
                      inputType: TextInputType.text,
                      customError: snapshot.hasError,
                      errorText: snapshot.error,
                      validate: (v) {
                        if (Validations.feedBack(v) != null) {
                          provider.feedback.addError(Validations.feedBack(v)!);
                        }
                        return null;
                      },
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
