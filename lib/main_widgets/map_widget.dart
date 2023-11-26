import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stepOut/app/core/utils/extensions.dart';
import '../app/core/utils/app_strings.dart';
import '../app/core/utils/dimensions.dart';
import '../components/shimmer/custom_shimmer.dart';
import '../features/maps/models/location_model.dart';
import '../main_providers/map_provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({this.point, super.key});
  final LocationModel? point;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider()
        ..setLocation(
          dropOff: point ?? AppStrings.defaultDrop,
        ),
      child: Consumer<MapProvider>(builder: (context, vm, _) {
        if (vm.isLoad) {
          return const MapWidgetShimmer();
        } else {
          return Column(
            children: [
              SizedBox(
                width: context.width,
                height: 120.h,
                child: GoogleMap(
                  initialCameraPosition: vm.mapCameraPosition,
                  onMapCreated: vm.onMapCreated,
                  padding: vm.googleMapPadding,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  markers: vm.gMapMarkers,
                  mapToolbarEnabled: false,
                  // polylines: vm.gMapPolyLines,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class MapWidgetShimmer extends StatelessWidget {
  const MapWidgetShimmer(
      {this.withStops = false, this.withClientName = false, Key? key})
      : super(key: key);
  final bool withStops;
  final bool withClientName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomShimmerContainer(
          width: context.width,
          height: 150.h,
          radius: 0,
        )
      ],
    );
  }
}
