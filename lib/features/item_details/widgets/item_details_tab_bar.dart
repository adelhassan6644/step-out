import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/features/item_details/provider/item_details_provider.dart';

import '../../../components/tab_widget.dart';

class ItemDetailsTabBar extends StatelessWidget {
  const ItemDetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
      return Row(
        children: List.generate(
            3,
            (index) => Expanded(
                  child: TabWidget(
                    fontSize: 15,
                    withUpperBorder: true,
                    label: provider.tabs[index],
                    isSelected: provider.selectedTab == index,
                    onTap: () => provider.onSelectTab(index),
                  ),
                )),
      );
    });
  }
}
