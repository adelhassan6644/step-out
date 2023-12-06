import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../item_details/model/item_details_model.dart';
import '../models/location_model.dart';
import '../models/prediction_model.dart';
import '../repo/maps_repo.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  final MapsRepo locationRepo;
  LocationProvider({
    required this.locationRepo,
  });

  List<PredictionModel> _predictionList = [];
  bool isLoading = false;
  String pickAddress = '';
  LocationModel? addressModel;
  Position? pickPosition;
  Future<List<PredictionModel>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Either<ServerFailure, Response> response =
          await locationRepo.searchLocation(text);
      response.fold((error) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(error),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        _predictionList = [];
        response.data['predictions'].forEach((prediction) =>
            _predictionList.add(PredictionModel.fromJson(prediction)));
      });
    }
    return _predictionList;
  }

  LocationModel? currentLocation;
  getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position newLocalData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Either<ServerFailure, Response> response =
        await locationRepo.getAddressFromGeocode(
            LatLng(newLocalData.latitude, newLocalData.longitude));
    response.fold((l) => null, (response) {
      pickAddress = response.data['results'][0]['formatted_address'].toString();
      currentLocation = LocationModel(
        latitude: newLocalData.latitude.toString(),
        longitude: newLocalData.longitude.toString(),
        address: response.data['results'][0]['formatted_address'].toString(),
      );
    });
    notifyListeners();
  }

  getLocation({required GoogleMapController mapController}) async {
    isLoading = true;
    notifyListeners();
    await Geolocator.requestPermission();
    pickPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    getNearPlaces(pickPosition);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(pickPosition!.latitude, pickPosition!.longitude),
          zoom: 14),
    ));

    await decodeLatLong(
      latitude: pickPosition!.latitude,
      longitude: pickPosition!.longitude,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> decodeLatLong({
    required latitude,
    required longitude,
  }) async {
    Either<ServerFailure, Response> response =
        await locationRepo.getAddressFromGeocode(LatLng(latitude, longitude));

    response.fold((l) => null, (response) {
      pickAddress = response.data['results'][0]['formatted_address'].toString();
      addressModel = LocationModel(
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        address: response.data['results'][0]['formatted_address'].toString(),
      );
      notifyListeners();
    });
  }

  updatePosition(
    CameraPosition position,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      pickPosition = Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speedAccuracy: 1,
          speed: 1,
          altitudeAccuracy: 1,
          headingAccuracy: 1);
      decodeLatLong(
          latitude: position.target.latitude,
          longitude: position.target.longitude);
      isLoading = false;
      getNearPlaces(position.target);

      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  List<ItemDetailsModel>? model;
  bool isGetPlaces = false;
  getNearPlaces(position) async {
    try {
      model?.clear();
      isGetPlaces = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await locationRepo.getNearPlaces(position: position);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        model = List<ItemDetailsModel>.from(
          success.data["data"].map(
            (x) => ItemDetailsModel.fromJson(x),
          ),
        );
      });
      isGetPlaces = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetPlaces = false;
      notifyListeners();
    }
  }
}
