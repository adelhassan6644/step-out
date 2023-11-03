import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';
import '../../app/core/utils/text_styles.dart';
import '../app/localization/language_constant.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key, this.timeBySecond = 60, this.onCount});
  final int timeBySecond;
  final Function? onCount;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late Timer _timer;
  int _count = 0;
  @override
  void initState() {
    countDown();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  countDown() {
    setState(() => _count = widget.timeBySecond);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_count != 0) {
        setState(() => --_count);
      } else {
        if (_timer.isActive) _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          getTranslated("didnt_receive_the_code", context),
          textAlign: TextAlign.start,
          style: AppTextStyles.medium.copyWith(
              color: Styles.TITLE,
              fontSize: 14,
              overflow: TextOverflow.ellipsis),
        ),
        InkWell(
          onTap: () {
            if (_count == 0) {
              countDown();
              if (widget.onCount != null) {
                widget.onCount!();
              }
            }
          },
          child: Text(
            " ${getTranslated("resend_code", context)}",
            textAlign: TextAlign.start,
            style: AppTextStyles.medium.copyWith(
              color: _count == 0 ? Styles.PRIMARY_COLOR : Styles.DISABLED,
              fontSize: 14,
            ),
          ),
        ),
        Text(
            " (${Duration(seconds: _count).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: _count).inSeconds.remainder(60).toString().padLeft(2, '0')})",
            textAlign: TextAlign.start,
            style: AppTextStyles.medium.copyWith(
                color: _count == 0 ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                fontSize: 14)),
      ],
    );
  }
}
