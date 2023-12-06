import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../features/maps/models/location_model.dart';

class MapProvider extends ChangeNotifier {
  CameraPosition mapCameraPosition =
      const CameraPosition(target: LatLng(24.280888, 37.987794), zoom: 5);
  GoogleMapController? googleMapController;
  EdgeInsets googleMapPadding = const EdgeInsets.all(40);
  Set<Marker> gMapMarkers = {};
  late LatLng? target;

  bool isLoad = false;

  void onMapCreated(GoogleMapController controller, LocationModel location) {
    isLoad = true;
    notifyListeners();
    googleMapController = controller;
    gMapMarkers = {};
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('destPin'),
        position: LatLng(
          double.parse(location.latitude ?? "30"),
          double.parse(location.longitude ?? "30"),
        ),
        icon: BitmapDescriptor.defaultMarker,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    target = LatLng(
      double.parse(location.latitude ?? "30"),
      double.parse(location.longitude ?? "30"),
    );
    setLocation();
  }

  setLocation() {
    googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        target!,
        14,
      ),
    );
    isLoad = false;
    notifyListeners();
  }
}
