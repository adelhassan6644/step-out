import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../features/maps/models/location_model.dart';

class MapProvider extends ChangeNotifier {
  CameraPosition mapCameraPosition =
      const CameraPosition(target: LatLng(24.280888, 37.987794), zoom: 5);
  GoogleMapController? googleMapController;
  EdgeInsets googleMapPadding = const EdgeInsets.all(40);
  Set<Polyline> gMapPolylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  Set<Marker> gMapMarkers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor? destinationIcon = BitmapDescriptor.defaultMarker;
  // LocationModel? pickupLocation;
  LocationModel? dropOffLocation;
  bool isLoad = false;
  setLocation({required LocationModel dropOff}) {
    isLoad = true;
    notifyListeners();
    polylineCoordinates = [];
    gMapMarkers = {};
    // pickupLocation = pickup;
    dropOffLocation = dropOff;
    drawTripPolyLines();
    isLoad = false;

    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();

    //start listening to user current location

    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = BitmapDescriptor.defaultMarker;
    //
    destinationIcon = BitmapDescriptor.defaultMarker;
    //
  }

  drawTripPolyLines() async {
    // source pin
    gMapMarkers = {};
    // gMapMarkers.add(
    //   Marker(
    //     markerId: const MarkerId('sourcePin'),
    //     position: LatLng(double.parse(pickupLocation!.latitude!),
    //         double.parse(pickupLocation!.longitude!)),
    //     icon: sourceIcon!,
    //     anchor: const Offset(0.5, 0.5),
    //   ),
    // );
    // destination pin
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('destPin'),
        position: LatLng(double.parse(dropOffLocation!.latitude!),
            double.parse(dropOffLocation!.longitude!)),
        icon: destinationIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    // //load the ploylines
    // PolylineResult polylineResult =
    //     await polylinePoints.getRouteBetweenCoordinates(
    //   AppStrings.googleApiKey,
    //   PointLatLng(double.parse(pickupLocation!.latitude!),
    //       double.parse(pickupLocation!.longitude!)),
    //   PointLatLng(double.parse(dropOffLocation!.latitude!),
    //       double.parse(dropOffLocation!.longitude!)),
    // );
    //get the points from the result
    // List<PointLatLng> result = polylineResult.points;
    //
    // if (result.isNotEmpty) {
    //   // loop through all PointLatLng points and convert them
    //   // to a list of LatLng, required by the Polyline
    //   result.forEach((PointLatLng point) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   });
    // }

    // with an id, an RGB color and the list of LatLng pairs
    // Polyline polyline = Polyline(
    //   polylineId: PolylineId("poly"),
    //   color: Styles.PRIMARY_COLOR,
    //   points: polylineCoordinates,
    //   width: 3,
    // );
//
//     gMapPolylines = {};
    // gMapPolylines.add(polyline);

    //
    //zoom to latbound
    // final pickupLocationLatLng = LatLng(double.parse(pickupLocation!.latitude!),
    //     double.parse(pickupLocation!.longitude!));
    final dropoffLocationLatLng = LatLng(
        double.parse(dropOffLocation!.latitude!),
        double.parse(dropOffLocation!.longitude!));

    await updateCameraLocation(
      // pickupLocationLatLng,
      dropoffLocationLatLng,
      googleMapController!,
    );
    //
    notifyListeners();
  }

  Future<void> updateCameraLocation(
    LatLng source,
    GoogleMapController mapController,
  ) async {
    LatLngBounds bounds;
    bounds = LatLngBounds(southwest: source, northeast: source);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 2);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
    CameraUpdate cameraUpdate,
    GoogleMapController mapController,
  ) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}
