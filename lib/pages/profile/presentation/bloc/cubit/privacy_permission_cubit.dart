import 'dart:developer';

import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/models/dummy/notification_tile_model.dart';
import 'package:fennac_app/pages/profile/data/models/privacy_permission_model.dart';
import 'package:fennac_app/pages/profile/domain/usecase/privacy_permission_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/privacy_permission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPermissionCubit extends Cubit<PrivacyPermissionState> {
  final PrivacyPermissionUsecase _privacyPermissionUsecase;

  PrivacyPermissionCubit(this._privacyPermissionUsecase)
    : super(PrivacyPermissionInitial());

  PrivacyPermissionModel? privacyPermissionModel;
  bool isSubmitting = false;

  final List<NotificationTileData> privacyItems = DummyConstants.privacyItems
      .map((e) => e.copyWith())
      .toList();

  Future<void> fetchPrivacyPermission() async {
    emit(PrivacyPermissionLoading());
    try {
      final response = await _privacyPermissionUsecase.fetchPrivacyPermission();
      privacyPermissionModel = response;

      final permissions = response.data?.privacyPermissions;
      if (permissions != null && privacyItems.length >= 4) {
        privacyItems[0] = privacyItems[0].copyWith(
          value: permissions.activityStatusEnabled,
        );
        privacyItems[1] = privacyItems[1].copyWith(
          value: permissions.locationSharingEnabled,
        );
        privacyItems[2] = privacyItems[2].copyWith(
          value: permissions.contactAccessEnabled,
        );
        privacyItems[3] = privacyItems[3].copyWith(
          value: permissions.mediaPermissionsEnabled,
        );
      }

      emit(PrivacyPermissionLoaded());
    } catch (e) {
      log('Error fetching privacy permission: $e');
      emit(PrivacyPermissionError(e.toString()));
    }
  }

  void togglePrivacy(int index, bool value) {
    emit(PrivacyPermissionLoading());
    privacyItems[index] = privacyItems[index].copyWith(value: value);
    _syncModelFromItems();
    emit(PrivacyPermissionLoaded());
  }

  Future<bool> updatePrivacyPermission() async {
    emit(PrivacyPermissionLoading());
    isSubmitting = true;
    try {
      _syncModelFromItems();

      final currentModel =
          privacyPermissionModel ??
          PrivacyPermissionModel(
            data: Data(privacyPermissions: PrivacyPermissions()),
          );

      final updatedResponse = await _privacyPermissionUsecase
          .updatePrivacyPermission(privacyPermissionModel: currentModel);

      privacyPermissionModel = updatedResponse;
      VxToast.show(
        message: updatedResponse.message ?? 'Privacy settings updated',
      );

      await fetchPrivacyPermission();
      isSubmitting = false;
      return true;
    } catch (e) {
      log('Error updating privacy permission: $e');
      VxToast.show(message: 'Failed to update privacy settings');
      isSubmitting = false;
      emit(PrivacyPermissionError(e.toString()));
      return false;
    }
  }

  void _syncModelFromItems() {
    final currentPermissions =
        privacyPermissionModel?.data?.privacyPermissions ??
        PrivacyPermissions();

    final updatedPermissions = currentPermissions.copyWith(
      activityStatusEnabled: privacyItems[0].value,
      locationSharingEnabled: privacyItems[1].value,
      contactAccessEnabled: privacyItems[2].value,
      mediaPermissionsEnabled: privacyItems[3].value,
    );

    final currentData = privacyPermissionModel?.data;
    final updatedData =
        currentData?.copyWith(privacyPermissions: updatedPermissions) ??
        Data(privacyPermissions: updatedPermissions);

    privacyPermissionModel =
        (privacyPermissionModel ?? PrivacyPermissionModel()).copyWith(
          data: updatedData,
        );
  }
}
