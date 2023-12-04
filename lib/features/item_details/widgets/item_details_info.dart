import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../provider/item_details_provider.dart';
import 'item_details_contact_info.dart';
import 'item_details_location.dart';
import 'item_details_offers.dart';
import 'item_services_widget.dart';

class ItemDetailsInfo extends StatelessWidget {
  final ItemDetailsModel? model;
  const ItemDetailsInfo({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ItemDetailsProvider>(builder: (_, provider, child) {
        return ListAnimator(
          customPadding:
          EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT.h),
          data: [
            ///Services
            const ItemServicesWidget(),

            ///Divider
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
              child: const Divider(
                color: Styles.BORDER_COLOR,
              ),
            ),

            ///Contact Info
            ItemDetailsContactInfo(
              phone: provider.model?.phone,
              times: provider.model?.times,
              tags: provider.model?.tags,
            ),

            ///Item Details Location
            ItemDetailsLocation(
              address: provider.model?.address,
              lat: provider.model?.lat,
              long: provider.model?.long,
              itemName: provider.model?.name,
            ),

            ///Divider
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
              child: const Divider(
                color: Styles.BORDER_COLOR,
              ),
            ),

            ///Item Details Offers
            ItemDetailsOffer(offers: provider.model?.offers),

            SizedBox(
              height: 24.h,
            )
          ],
        );
      }),
    );
  }
}
