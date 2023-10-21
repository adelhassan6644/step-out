import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepOut/app/core/utils/color_resources.dart';
import 'package:stepOut/app/core/utils/dimensions.dart';
import 'package:stepOut/app/core/utils/extensions.dart';

import '../app/core/utils/svg_images.dart';
import 'custom_error_widget.dart';
import 'custom_images.dart';

class CustomTextField extends StatefulWidget {
  final IconData? suffixIcon;
  final TextInputAction keyboardAction;
  final Color? iconColor;
  final TextInputType? inputType;
  final String? hint;
  final String? label;
  final void Function(String)? onChanged;
  final bool isPassword;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validate;
  final int? maxLines;
  final TextEditingController? controller;
  final bool keyboardPadding;
  final bool withLabel;
  final bool readOnly;
  final int? maxLength;
  final bool obscureText;
  final bool? autoFocus;
  final bool? alignLabel;
  final dynamic errorText;
  final String? initialValue;
  final bool isEnabled;
  final bool? alignLabelWithHint;
  final Widget? prefixIcon;
  final bool? withPadding;
  final Widget? suffixWidget;
  final bool withWidth;
  final bool? customError;
  final GestureTapCallback? onTap;
  final Color? onlyBorderColor;
  final List<TextInputFormatter>? formattedType;
  final Alignment? align;

  const CustomTextField({
    Key? key,
    this.suffixIcon,
    this.keyboardAction = TextInputAction.next,
    this.align,
    this.inputType,
    this.hint,
    this.alignLabelWithHint,
    this.onChanged,
    this.validate,
    this.obscureText = false,
    this.isPassword = false,
    this.withWidth = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.isEnabled = true,
    this.withPadding = true,
    this.alignLabel = false,
    this.controller,
    this.errorText = "",
    this.maxLength,
    this.formattedType,
    this.focusNode,
    this.iconColor,
    this.keyboardPadding = false,
    this.autoFocus,
    this.initialValue,
    this.onSubmit,
    this.prefixIcon,
    this.onlyBorderColor,
    this.suffixWidget,
    this.customError = false,
    this.withLabel = false,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.withWidth ? context.width * .8 : context.width,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Styles.FILL_COLOR,
              border: Border.all(
                  color: widget.alignLabel!
                      ? Styles.PRIMARY_COLOR
                      : Styles.BORDER_COLOR),
              borderRadius: BorderRadius.circular(15.0)),
          height: 65,
          child: Center(
            child: TextFormField(
              focusNode: widget.focusNode,
              initialValue: widget.initialValue,
              textInputAction: widget.keyboardAction,
              textAlignVertical: widget.inputType == TextInputType.phone
                  ? TextAlignVertical.center
                  : TextAlignVertical.top,
              onTap: widget.onTap,
              autofocus: widget.autoFocus ?? false,
              maxLength: widget.maxLength,
              onFieldSubmitted: widget.onSubmit,
              readOnly: widget.readOnly,
              obscureText:
                  widget.isPassword == true ? _isHidden : widget.obscureText,
              controller: widget.controller,
              maxLines: widget.maxLines,
              validator: widget.validate,
              keyboardType: widget.inputType,
              onChanged: widget.onChanged,
              inputFormatters: widget.inputType == TextInputType.phone
                  ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
                  : widget.formattedType ?? [],
              onTapOutside: (v) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
                color: Styles.HEADER,
              ),
              scrollPhysics: const BouncingScrollPhysics(),
              scrollPadding: EdgeInsets.only(
                  bottom: widget.keyboardPadding ? context.bottom : 0.0),
              decoration: InputDecoration(
                enabled: widget.isEnabled,
                labelText: widget.label,
                hintText: widget.hint ?? '',
                alignLabelWithHint:
                    widget.alignLabelWithHint ?? widget.alignLabel,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                errorMaxLines: 2,
                labelStyle: const TextStyle(
                    color: Styles.PRIMARY_COLOR,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                floatingLabelStyle: const TextStyle(
                    color: Styles.PRIMARY_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(
                  color: Styles.HINT_COLOR,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: widget.isPassword == true
                    ? IconButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.withPadding! ? 16.w : 0,
                        ),
                        onPressed: _visibility,
                        alignment: Alignment.center,
                        icon: _isHidden
                            ? customImageIconSVG(
                                imageName: SvgImages.hiddenEyeIcon,
                                height: 16.55.h,
                                width: 19.59.w,
                                color: const Color(0xFF8B97A3),
                              )
                            : customImageIconSVG(
                                imageName: SvgImages.eyeIcon,
                                height: 16.55.h,
                                width: 19.59.w,
                                color: Styles.PRIMARY_COLOR,
                              ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.withPadding! ? 16.w : 0,
                        ),
                        child: widget.suffixIcon != null
                            ? Icon(
                                widget.suffixIcon,
                                size: 18,
                                color: widget.iconColor ?? Colors.grey[400],
                              )
                            : widget.suffixWidget),
                prefixIcon: widget.withPadding!
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.withPadding! ? 16.w : 0,
                        ),
                        child: widget.prefixIcon,
                      )
                    : widget.prefixIcon,
                prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
                suffixIconConstraints: BoxConstraints(maxHeight: 25.h),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
          ),
        ),
        widget.customError!
            ? CustomErrorWidget(error: widget.errorText)
            : Container()
      ],
    );
  }
}
