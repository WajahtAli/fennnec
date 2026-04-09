import 'dart:async';
import 'package:fennac_app/pages/filter/presentation/bloc/state/google_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapStateInitial());

  // Controllers
  Completer<GoogleMapController> mapController = Completer();
  ScrollController scrollController = ScrollController();

  // Map related variables
  String mapStyle = "";
  List<Marker> markers = [];
  List<LatLng> polylineCoordinates = [];
  LatLng cameraPosition = const LatLng(37.42796133580664, -122.085749655962);

  // Location related variables
  Position? currentLocation;
  LatLng? selectedMapCenter;
  geocoding.Placemark? address;
  StreamSubscription<Position>? positionStreamSubscription;
  LocationPermission? locationStatus;

  // Markers
  Uint8List? pointerMarker;
  Uint8List? userMarker;

  // Ride related variables
  int selectedRideIndex = 0;
  bool showRidingSection = false;

  // Sample driver locations
  final List<LatLng> driverLocations = [
    const LatLng(30.192668, 71.485530),
    const LatLng(30.199463, 71.479393),
  ];

  Future<void> initialize() async {
    emit(GoogleMapStateLoading());

    try {
      await Future.wait([_getUserCurrentLocation()]);

      if (currentLocation != null) {
        await _getAddressFromLatLng(currentLocation!);
        _listenToLocation();
      }

      emit(GoogleMapStateLoaded());
    } catch (e) {
      emit(GoogleMapStateError(e.toString()));
    }
  }

  Future<Position?> _getUserCurrentLocation() async {
    await _checkAndRequestPermissions();
    await _checkAndRequestService();

    currentLocation = await Geolocator.getCurrentPosition();
    return currentLocation;
  }

  // get location
  Future<void> getLocation() async {
    await _getUserCurrentLocation().then((value) {
      if (value != null) {
        _getAddressFromLatLng(value);
      }
    });
  }

  Future<void> _checkAndRequestPermissions() async {
    locationStatus = await Geolocator.requestPermission();
    if (locationStatus == LocationPermission.denied) {
      locationStatus = await Geolocator.requestPermission();
    }
    if (locationStatus == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
      throw Exception("Location permission permanently denied");
    }
  }

  Future<void> _checkAndRequestService() async {
    await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await Geolocator.servi();
    //   if (!serviceEnabled) {
    //     throw Exception("Location service is disabled");
    //   }
    // }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(position.latitude, position.longitude);
    address = placemarks[0];
  }

  Future<void> _listenToLocation() async {
    LocationSettings settings = const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 7,
    );

    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: settings).listen((
          Position locationData,
        ) {
          currentLocation = locationData;
          emit(GoogleMapStateLocationUpdated(locationData));
        });
  }

  Future<void> goToCurrentLocation() async {
    emit(GoogleMapStateMovingCamera());
    final GoogleMapController controller = await mapController.future;
    if (currentLocation != null) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation!.latitude,
              currentLocation!.longitude,
            ),
            zoom: 16,
          ),
        ),
      );
    }
    emit(GoogleMapStateCameraMoved());
  }

  Future<void> moveToSelectedLocation({
    required double latitude,
    required double longitude,
  }) async {
    emit(GoogleMapStateMovingCamera());
    selectedMapCenter = LatLng(latitude, longitude);

    if (mapController.isCompleted) {
      final GoogleMapController controller = await mapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: selectedMapCenter!, zoom: 14.5),
        ),
      );
    }

    emit(GoogleMapStateCameraMoved());
  }

  void changeIndex(int index) {
    emit(GoogleMapStateChangingRideIndex());
    selectedRideIndex = index;
    emit(GoogleMapStateRideIndexChanged(index));
  }

  void changeRidingSectionVisibility(bool show) {
    emit(GoogleMapStateChangingRidingSection());
    showRidingSection = show;
    emit(
      show
          ? GoogleMapStateRidingSectionShown()
          : GoogleMapStateRidingSectionHidden(),
    );
  }

  void stopListeningToLocation() {
    positionStreamSubscription?.cancel();
    emit(GoogleMapStateLocationListeningStopped());
  }

  @override
  Future<void> close() {
    stopListeningToLocation();
    return super.close();
  }
}
