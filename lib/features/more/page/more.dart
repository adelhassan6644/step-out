import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListAnimator(
            customPadding: EdgeInsets.only(
                top: (Dimensions.PADDING_SIZE_DEFAULT.h + context.toPadding)),
            data: const [
              ProfileCard(),
              MoreOptions(),
            ],
          ),
        )
      ],
    );
  }
}
