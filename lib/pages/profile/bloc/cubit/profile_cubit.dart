import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/models/dummy/notification_tile_model.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/profile_state.dart';
import 'package:fennac_app/pages/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase _profileUsecase;

  ProfileCubit(this._profileUsecase) : super(ProfileInitial());

  bool isSubmitting = false;
  dynamic verifyContactChangeResponse;
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
    try {
      final response = await _profileUsecase.requestContactChange(
        email: normalizedEmail,
        phone: normalizedPhone,
      );

      VxToast.show(
        message: response['message'] ?? 'Verification code sent successfully',
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

  Future<bool> verifyEmailOrPhoneOtp({
    required String requestId,
    required String verificationCode,
  }) async {
    final normalizedRequestId = requestId.trim();
    final normalizedCode = verificationCode.trim();

    if (normalizedRequestId.isEmpty || normalizedCode.isEmpty) {
      VxToast.show(message: 'Please provide request id and code');
      return false;
    }

    emit(ProfileLoading());
    isSubmitting = true;
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
      VxToast.show(message: e.toString());
      isSubmitting = false;
      emit(ProfileError());
      return false;
    }
  }
}
