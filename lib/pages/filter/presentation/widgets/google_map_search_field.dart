import 'dart:convert';
import 'dart:async';

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/state/google_map_state.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleMapSearchPlacesApi extends StatefulWidget {
  final String? initialAddress;
  final void Function(
    double latitude,
    double longitude,
    String address,
    String city,
    String state,
  )?
  onPlaceSelected;

  const GoogleMapSearchPlacesApi({
    super.key,
    this.initialAddress,
    this.onPlaceSelected,
  });

  @override
  State<GoogleMapSearchPlacesApi> createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();
  final _uuid = const Uuid();
  String _sessionToken = '';
  List<dynamic> _placeList = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialAddress ?? '';
    _listenToCameraMovements();
  }

  void _listenToCameraMovements() {
    final googleMapCubit = Di().sl<GoogleMapCubit>();
    // Subscribe to cubit state changes
    googleMapCubit.stream.listen((state) {
      if (state is GoogleMapStateMarkersUpdated) {
        if (googleMapCubit.selectedAddress != null &&
            googleMapCubit.selectedAddress!.isNotEmpty) {
          if (mounted) {
            _controller.text = googleMapCubit.selectedAddress!;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      getSuggestion(value);
    });
  }

  Future<void> getSuggestion(String input) async {
    if (input.trim().isEmpty) {
      setState(() => _placeList = []);
      return;
    }
    if (_sessionToken.isEmpty) {
      _sessionToken = _uuid.v4();
    }
    try {
      const String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      final String request =
          '$baseURL?input=$input&key=${AppConstants.googleApiKey}&sessiontoken=$_sessionToken';
      final response = await http.get(Uri.parse(request));
      if (kDebugMode) print('Places: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'] ?? [];
        });
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  String _extractAddressComponent(
    List<dynamic>? components,
    List<String> acceptedTypes,
  ) {
    if (components == null) return '';
    for (final component in components) {
      if (component is! Map<String, dynamic>) continue;
      final types = (component['types'] as List?)?.cast<String>() ?? const [];
      final hasMatch = acceptedTypes.any(types.contains);
      if (hasMatch) {
        return (component['long_name'] as String?) ??
            (component['short_name'] as String?) ??
            '';
      }
    }
    return '';
  }

  Future<({double lat, double lng, String city, String state, String address})?>
  _getPlaceCoordinates(String placeId) async {
    try {
      const String baseUrl =
          'https://maps.googleapis.com/maps/api/place/details/json';
      final String request =
          '$baseUrl?place_id=$placeId&key=${AppConstants.googleApiKey}&sessiontoken=$_sessionToken';
      final response = await http.get(Uri.parse(request));

      if (response.statusCode != 200) {
        return null;
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final location = data['result']?['geometry']?['location'];
      final result = data['result'] as Map<String, dynamic>?;
      if (location == null) {
        return null;
      }

      final lat = (location['lat'] as num?)?.toDouble();
      final lng = (location['lng'] as num?)?.toDouble();
      if (lat == null || lng == null) {
        return null;
      }

      final components = result?['address_components'] as List<dynamic>?;
      final city = _extractAddressComponent(components, const [
        'locality',
        'administrative_area_level_2',
      ]);
      final state = _extractAddressComponent(components, const [
        'administrative_area_level_1',
      ]);
      final address = (result?['formatted_address'] as String?) ?? '';

      return (lat: lat, lng: lng, city: city, state: state, address: address);
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    final fieldBg = isLight ? Colors.white : ColorPalette.cardBlack;
    final borderColor = isLight
        ? ColorPalette.lightBorder
        : const Color(0x80666666);
    final textColor = isLight ? Colors.black : Colors.white;
    final hintColor = isLight
        ? ColorPalette.border
        : ColorPalette.textSecondary;
    final dividerColor = isLight
        ? ColorPalette.lightDivider
        : Colors.white.withValues(alpha: 0.08);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Search field ──────────────────────────────────────────
        Container(
          height: 52,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: fieldBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isLight ? 0.08 : 0.3),
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              SvgPicture.asset(
                Assets.icons.search.path,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  isLight ? Colors.black54 : Colors.white60,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: _onChanged,

                  style: AppTextStyles.body(context).copyWith(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Search location...',
                    hintStyle: AppTextStyles.body(
                      context,
                    ).copyWith(color: hintColor),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (_controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _debounce?.cancel();
                    setState(() {
                      _placeList = [];
                      _sessionToken = '';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: hintColor,
                    ),
                  ),
                )
              else
                const SizedBox(width: 12),
            ],
          ),
        ),

        // ── Suggestions list ──────────────────────────────────────
        if (_placeList.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              border: Border.all(color: borderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isLight ? 0.08 : 0.35),
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: _placeList.length.clamp(0, 5),
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: dividerColor),
              itemBuilder: (context, index) {
                final desc = _placeList[index]['description'] as String? ?? '';
                final placeId = _placeList[index]['place_id'] as String?;
                return InkWell(
                  onTap: () async {
                    _controller.text = desc;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: desc.length),
                    );

                    if (placeId != null) {
                      final coordinates = await _getPlaceCoordinates(placeId);
                      if (coordinates != null) {
                        widget.onPlaceSelected?.call(
                          coordinates.lat,
                          coordinates.lng,
                          coordinates.address.isNotEmpty
                              ? coordinates.address
                              : desc,
                          coordinates.city,
                          coordinates.state,
                        );
                      }
                    }

                    setState(() {
                      _placeList = [];
                      _sessionToken = '';
                    });
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: ColorPalette.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            desc,
                            style: AppTextStyles.label(
                              context,
                            ).copyWith(color: textColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
