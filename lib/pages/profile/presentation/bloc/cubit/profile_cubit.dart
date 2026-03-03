import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/models/dummy/notification_tile_model.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/pages/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase _profileUsecase;

  ProfileCubit(this._profileUsecase) : super(ProfileInitial());

  bool isSubmitting = false;
  dynamic changeContactResponse;
  String? changeContactRequestId;
  dynamic verifyContactChangeResponse;
  String? otpErrorMessage;
  final List<NotificationTileData> notificationItems = DummyConstants
      .notificationItems
      .map((e) => e.copyWith())
      .toList();

  final List<NotificationTileData> privacyItems = DummyConstants.privacyItems
      .map((e) => e.copyWith())
      .toList();

  void toggleNotification(int index, bool value) {
    emit(ProfileLoading());
    notificationItems[index] = notificationItems[index].copyWith(value: value);
    emit(ProfileLoaded());
  }

  void togglePrivacy(int index, bool value) {
    emit(ProfileLoading());
    privacyItems[index] = privacyItems[index].copyWith(value: value);
    emit(ProfileLoaded());
  }

  Future<bool> changeEmailOrPhone({String? email, String? phone}) async {
    final normalizedEmail = email?.trim();
    final normalizedPhone = phone?.trim();

    if ((normalizedEmail == null || normalizedEmail.isEmpty) &&
        (normalizedPhone == null || normalizedPhone.isEmpty)) {
      VxToast.show(message: 'Please provide email or phone');
      return false;
    }

    emit(ProfileLoading());
    isSubmitting = true;
    otpErrorMessage = null;
    try {
      final response = await _profileUsecase.requestContactChange(
        email: normalizedEmail,
        phone: normalizedPhone,
      );

      changeContactResponse = response;
      changeContactRequestId = _extractRequestId(response);

      VxToast.show(
        message: response['message'] ?? 'Verification code sent successfully',
        icon: Assets.icons.checkGreen.path,
      );
      isSubmitting = false;
      emit(ProfileLoaded());
      return true;
    } catch (e) {
      otpErrorMessage = e.toString();
      VxToast.show(message: otpErrorMessage!);
      isSubmitting = false;
      emit(ProfileError());
      return false;
    }
  }

  Future<bool> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  }) async {
    final normalizedRequestId = requestId.trim().isNotEmpty
        ? requestId.trim()
        : (changeContactRequestId ?? '').trim();
    final normalizedCode = verificationCode.trim();

    if (normalizedRequestId.isEmpty || normalizedCode.isEmpty) {
      otpErrorMessage = 'Please provide request id and code';
      VxToast.show(message: otpErrorMessage!);
      return false;
    }

    emit(ProfileLoading());
    isSubmitting = true;
    otpErrorMessage = null;
    try {
      final response = await _profileUsecase.verifyEmailOrPhoneOtp(
        requestId: normalizedRequestId,
        verificationCode: normalizedCode,
      );

      verifyContactChangeResponse = response;

      VxToast.show(
        message: response['message'] ?? 'Verification successful',
        icon: Assets.icons.checkGreen.path,
      );
      isSubmitting = false;
      emit(ProfileLoaded());
      return true;
    } catch (e) {
      otpErrorMessage = e.toString();
      VxToast.show(message: otpErrorMessage!);
      isSubmitting = false;
      emit(ProfileError());
      return false;
    }
  }

  String? get contactChangeRequestId {
    return changeContactRequestId ?? _extractRequestId(changeContactResponse);
  }

  String? _extractRequestId(dynamic response) {
    if (response is Map<String, dynamic>) {
      final direct = response['requestId'];
      if (direct is String && direct.isNotEmpty) {
        return direct;
      }
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final nested = data['requestId'];
        if (nested is String && nested.isNotEmpty) {
          return nested;
        }
      }
    }
    return null;
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    if (currentPassword.isEmpty || newPassword.isEmpty) {
      VxToast.show(message: 'Please provide current and new password');
      return false;
    }

    emit(ProfileLoading());
    isSubmitting = true;
    try {
      final response = await _profileUsecase.changePassword(
        currentPassword: currentPassword.trim(),
        newPassword: newPassword.trim(),
      );
      Di().sl<AuthCubit>().confirmNewPasswordController.clear();
      Di().sl<AuthCubit>().newPasswordController.clear();
      Di().sl<AuthCubit>().currentPasswordController.clear();
      AutoRouter.of(context).pop();
      VxToast.show(
        message: response['message'] ?? 'Password changed successfully',
        icon: Assets.icons.checkGreen.path,
      );
      isSubmitting = false;

      emit(ProfileLoaded());
      return true;
    } catch (e) {
      VxToast.show(message: e.toString());
      isSubmitting = false;
      emit(ProfileError());
      return false;
    }
  }
}
