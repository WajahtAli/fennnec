import 'dart:async';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/di_container.dart';
import '../../../../generated/assets.gen.dart';
import '../bloc/cubit/google_map_cubit.dart';
import '../bloc/state/google_map_state.dart';

class GoogleMapWidget extends StatefulWidget {
  final int distanceMiles;

  const GoogleMapWidget({super.key, required this.distanceMiles});

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  static const double _metersPerMile = 1609.344;
  final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
  GoogleMapController? mapController;

  Future<void> setMapStyle() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final style = await DefaultAssetBundle.of(
      context,
    ).loadString(isDarkMode ? Assets.json.mapDark : Assets.json.mapLight);
    mapController?.setMapStyle(style);
  }

  @override
  void initState() {
    super.initState();
    _googleMapCubit.initialize();
  }

  @override
  void dispose() {
    _googleMapCubit.mapController = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, GoogleMapState>(
      bloc: _googleMapCubit,
      listener: (context, state) {
        if (state is GoogleMapStateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is GoogleMapStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GoogleMapStateError) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: AppTextStyles.bodyRegular(context),
            ),
          );
        }

        return GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,

          initialCameraPosition: _getInitialCameraPosition(),
          onMapCreated: _onMapCreated,
          onCameraMove: _onCameraMove,
          markers: _buildMarkers(),
          circles: _buildDistanceCircle(),
        );
      },
    );
  }

  CameraPosition _getInitialCameraPosition() {
    final selected = _googleMapCubit.selectedMapCenter;
    return CameraPosition(
      target: LatLng(
        selected?.latitude ?? _googleMapCubit.currentLocation?.latitude ?? 0.0,
        selected?.longitude ??
            _googleMapCubit.currentLocation?.longitude ??
            0.0,
      ),
      zoom: 14.5,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapCubit.mapController.complete(controller);
    mapController = controller;
    setMapStyle();
    final selected = _googleMapCubit.selectedMapCenter;
    if (selected != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: selected, zoom: 14.5),
        ),
      );
    }
  }

  void _onCameraMove(CameraPosition position) {
    // _googleMapCubit.updateMarkers(position);
  }

  Set<Circle> _buildDistanceCircle() {
    final selected = _googleMapCubit.selectedMapCenter;
    final location = _googleMapCubit.currentLocation;
    if (selected == null && location == null) {
      return {};
    }

    final primary = ColorPalette.primary;
    final radiusMeters = widget.distanceMiles * _metersPerMile;

    return {
      Circle(
        circleId: const CircleId('distance_range'),
        center: selected ?? LatLng(location!.latitude, location.longitude),
        radius: radiusMeters,
        fillColor: isDarkTheme(context)
            ? ColorPalette.textGrey.withValues(alpha: 0.28)
            : primary.withValues(alpha: 0.28),
        strokeColor: isDarkTheme(context)
            ? ColorPalette.textGrey.withValues(alpha: 0.75)
            : primary.withValues(alpha: 0.75),
        strokeWidth: 2,
      ),
    };
  }

  Set<Marker> _buildMarkers() {
    final selected = _googleMapCubit.selectedMapCenter;
    if (selected == null) {
      return {};
    }

    return {
      Marker(
        markerId: const MarkerId('selected_location_marker'),
        position: selected,
      ),
    };
  }
}
