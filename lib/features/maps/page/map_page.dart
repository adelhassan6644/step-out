import 'package:stepOut/app/core/utils/extensions.dart';
import 'package:stepOut/app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../data/config/di.dart';
import '../../../main_models/base_model.dart';
import '../provider/location_provider.dart';
import '../widget/near_places.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  const MapPage({this.baseModel, Key? key}) : super(key: key);
  final BaseModel? baseModel;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => getInitialPosition());
    super.initState();
  }

  getInitialPosition() {
    sl<LocationProvider>().getCurrentLocation();
    if (sl<LocationProvider>().pickPosition != null) {
      _initialPosition = LatLng(sl<LocationProvider>().pickPosition!.latitude,
          (sl<LocationProvider>().pickPosition!.longitude));
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: 100),
      ));
      sl<LocationProvider>().getNearPlaces(_initialPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LocationProvider>(
          builder: (_, provider, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        bearing: 192,
                        target: LatLng(
                          double.parse(AppStrings.defaultLat),
                          double.parse(AppStrings.defaultLong),
                        ),
                        zoom: 14,
                      ),
                      myLocationEnabled: true,
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                        provider.getLocation(mapController: _mapController!);
                      },
                      scrollGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        provider.updatePosition(
                          _cameraPosition,
                        );
                      },
                    ),
                    ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                        child: SizedBox(
                          height: context.toPadding,
                          width: context.width,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                    child: !provider.isLoading
                        ? const Icon(
                            Icons.location_on_rounded,
                            size: 50,
                            color: Styles.PRIMARY_COLOR,
                          )
                        : const CupertinoActivityIndicator()),
                Padding(
                  padding: EdgeInsets.only(bottom: 25.h),
                  child: const NearPlaces(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
