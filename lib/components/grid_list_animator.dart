import 'package:flutter/cupertino.dart';
import '../app/core/utils/dimensions.dart';

class GridListAnimatorWidget extends StatelessWidget {
  const GridListAnimatorWidget(
      {this.aspectRatio, required this.items, Key? key, this.columnCount})
      : super(key: key);
  final List<Widget> items;
  final double? aspectRatio;
  final int? columnCount;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 20.h),
      crossAxisCount: columnCount??2,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      mainAxisSpacing: 8.h,
      childAspectRatio: aspectRatio ?? 0.748,
      crossAxisSpacing: 8.w,
      children: items,
    );
  }
}
