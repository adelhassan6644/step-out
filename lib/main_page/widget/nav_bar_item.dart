import 'package:flutter/material.dart';
import '../../../app/core/utils/styles.dart';
import '../../components/custom_images.dart';

class BottomNavBarItem extends StatelessWidget {
  final String? imageIcon;
  final String? svgIcon;
  final VoidCallback onTap;
  final bool isSelected, withIconColor;
  final String? name;
  final double? width;
  final double? height;

  const BottomNavBarItem({
    super.key,
    this.imageIcon,
    this.svgIcon,
    this.name,
    this.isSelected = false,
    this.withIconColor = true,
    required this.onTap,
    this.width = 24,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedCrossFade(
                crossFadeState: isSelected
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
                firstChild: Center(
                    child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: const BoxDecoration(
                      color: Styles.ACCENT_COLOR, shape: BoxShape.circle),
                  child: const SizedBox(),
                )),
                secondChild: const SizedBox(
                  height: 6,
                )),
            svgIcon != null
                ? customImageIconSVG(
                    imageName: svgIcon!,
                    color: isSelected
                        ? Styles.ACCENT_COLOR
                        : withIconColor
                            ? Styles.DISABLED
                            : null,
                    width: width,
                    height: height)
                : customImageIcon(
                    imageName: imageIcon!,
                    height: height,
                    color: isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                    width: width,
                  ),
            name != null
                ? Text(
                    name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color:
                          isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
