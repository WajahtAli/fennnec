import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/state/google_map_state.dart';
import 'package:fennac_app/pages/filter/presentation/widgets/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MapWidget extends StatelessWidget {
  final int distanceMiles;
  final Widget? overlayWidget;

  const MapWidget({super.key, required this.distanceMiles, this.overlayWidget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      bloc: _googleMapCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map container
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 408,
                child: Stack(
                  children: [
                    GoogleMapWidget(distanceMiles: distanceMiles),

                    if (overlayWidget != null)
                      Positioned(
                        top: 12,
                        left: 0,
                        right: 0,
                        child: overlayWidget!,
                      ),

                    if (state is GoogleMapStateLoading)
                      IgnorePointer(
                        ignoring: true,
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                          child: Center(
                            child: Lottie.asset(
                              Assets.animations.loadingSpinner,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: getHeight(context) * 0.03),
          ],
        );
      },
    );
  }
}

final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
