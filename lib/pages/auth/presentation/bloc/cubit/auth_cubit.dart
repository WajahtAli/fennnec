import 'dart:async';
import 'package:fennac_app/pages/auth/presentation/bloc/state/auth_state.dart';
import 'package:fennac_app/widgets/custom_country_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // UI states
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool obscureNewPassword = true;
  bool obscureCurrentPassword = true;
  bool obscureConfirmNewPassword = true;
  bool isEmail = true;

  // OTP states
  int _remainingSeconds = 10; // 1 minute
  Timer? _otpTimer;
  bool _canResendOtp = false;
  String? _otpErrorMessage;
  bool _isOtpBlurred = false;

  int get remainingSeconds => _remainingSeconds;
  bool get canResendOtp => _canResendOtp;
  String? get otpErrorMessage => _otpErrorMessage;
  bool get isOtpBlurred => _isOtpBlurred;

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  Country? selectedCountry;

  bool _firstNameTouched = false;
  bool _lastNameTouched = false;
  bool _emailTouched = false;
  bool _phoneTouched = false;
  bool _passwordTouched = false;
  bool _confirmPasswordTouched = false;
  bool _newPasswordTouched = false;
  bool _confirmNewPasswordTouched = false;
  bool _currentPasswordTouched = false;

  int _validationCounter = 0;

  void togglePasswordVisibility() {
    emit(AuthValidationLoading());
    obscurePassword = !obscurePassword;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void toggleConfirmPasswordVisibility() {
    emit(AuthValidationLoading());
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void toggleCurrentPasswordVisibility() {
    emit(AuthValidationLoading());
    obscureCurrentPassword = !obscureCurrentPassword;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void toggleNewPasswordVisibility() {
    emit(AuthValidationLoading());
    obscureNewPassword = !obscureNewPassword;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void toggleConfirmNewPasswordVisibility() {
    emit(AuthValidationLoading());
    obscureConfirmNewPassword = !obscureConfirmNewPassword;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void toggleEmailOrPhone() {
    emit(AuthValidationLoading());
    isEmail = !isEmail;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void clearCreateAccountFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _firstNameTouched = false;
    _lastNameTouched = false;
    _emailTouched = false;
    _phoneTouched = false;
    _passwordTouched = false;
    _confirmPasswordTouched = false;
    _validationCounter++;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a valid email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (phoneDigits.isEmpty) {
      return 'Phone number is required';
    }

    final selectedPhoneCode =
        selectedCountry?.phoneCode?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';

    var e164Digits = phoneDigits;
    if (selectedPhoneCode.isNotEmpty &&
        !phoneDigits.startsWith(selectedPhoneCode)) {
      // Support local input in the field (without country code) by prepending
      // selected country code before validating E.164.
      e164Digits = '$selectedPhoneCode$phoneDigits';
    }

    final e164 = '+$e164Digits';
    final e164Regex = RegExp(r'^\+[1-9]\d{1,14}$');
    if (!e164Regex.hasMatch(e164)) {
      return 'Enter a valid phone number in E.164 format';
    }

    final iso = selectedCountry?.iso;

    // NANP (US/CA) => +1 followed by exactly 10 national digits.
    if (iso == 'US' || iso == 'CA') {
      if (!e164Digits.startsWith('1')) {
        return 'US/Canada number must start with country code 1';
      }

      final national = e164Digits.substring(1);
      if (national.length != 10) {
        return 'US/Canada number must be 10 digits after country code';
      }
    }

    // Pakistan mobile (as requested) => +92 followed by 10 digits, typically
    // starting with 3 (e.g. +923001234567).
    if (iso == 'PK') {
      if (!e164Digits.startsWith('92')) {
        return 'Pakistan number must start with country code 92';
      }

      var national = e164Digits.substring(2);
      if (national.startsWith('0')) {
        national = national.substring(1);
      }

      if (national.length != 10 || !national.startsWith('3')) {
        return 'Enter a valid Pakistan mobile number (e.g. +923001234567)';
      }
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }

    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }

    return null;
  }

  String? validateConfirmNewPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }

    if (value != password) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  void onFirstNameChanged(String value) {
    emit(AuthValidationLoading());
    _firstNameTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onLastNameChanged(String value) {
    emit(AuthValidationLoading());
    _lastNameTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onEmailChanged(String value) {
    emit(AuthValidationLoading());

    _emailTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onPhoneChanged(String value) {
    emit(AuthValidationLoading());
    _phoneTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onPasswordChanged(String value) {
    emit(AuthValidationLoading());

    _passwordTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onConfirmPasswordChanged(String value) {
    emit(AuthValidationLoading());
    _confirmPasswordTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onNewPasswordChanged(String value) {
    emit(AuthValidationLoading());
    _newPasswordTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onCurrentPasswordChanged(String value) {
    emit(AuthValidationLoading());
    _currentPasswordTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void onConfirmNewPasswordChanged(String value) {
    emit(AuthValidationLoading());
    _confirmNewPasswordTouched = true;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  String? getFirstNameError() {
    try {
      return _firstNameTouched ? validateName(firstNameController.text) : null;
    } catch (e) {
      return null;
    }
  }

  String? getLastNameError() {
    try {
      return _lastNameTouched ? validateName(lastNameController.text) : null;
    } catch (e) {
      return null;
    }
  }

  String? getEmailError() {
    try {
      return _emailTouched ? validateEmail(emailController.text) : null;
    } catch (e) {
      return null;
    }
  }

  String? getPhoneError() {
    try {
      return _phoneTouched ? validatePhoneNumber(phoneController.text) : null;
    } catch (e) {
      return null;
    }
  }

  String? getPasswordError() {
    try {
      return _passwordTouched
          ? validatePassword(passwordController.text)
          : null;
    } catch (e) {
      return null;
    }
  }

  String? getConfirmPasswordError() {
    try {
      return _confirmPasswordTouched
          ? validateConfirmPassword(
              confirmPasswordController.text,
              passwordController.text,
            )
          : null;
    } catch (e) {
      return null;
    }
  }

  String? getCurrentPasswordError() {
    try {
      return _currentPasswordTouched
          ? validateNewPassword(currentPasswordController.text)
          : null;
    } catch (e) {
      return null;
    }
  }

  String? getNewPasswordError() {
    try {
      return _newPasswordTouched
          ? validateNewPassword(newPasswordController.text)
          : null;
    } catch (e) {
      return null;
    }
  }

  String? getConfirmNewPasswordError() {
    try {
      return _confirmNewPasswordTouched
          ? validateConfirmNewPassword(
              confirmNewPasswordController.text,
              newPasswordController.text,
            )
          : null;
    } catch (e) {
      return null;
    }
  }

  void submit() {
    _firstNameTouched = true;
    _lastNameTouched = true;
    _emailTouched = true;
    _phoneTouched = true;
    _passwordTouched = true;
    _confirmPasswordTouched = true;
    _validationCounter++;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  bool isFormValid() {
    return getFirstNameError() == null &&
        getLastNameError() == null &&
        getEmailError() == null &&
        getPhoneError() == null &&
        getPasswordError() == null &&
        getConfirmPasswordError() == null;
  }

  void loadCountry() {
    emit(AuthValidationLoading());
    loadCountries().then((countries) {
      selectedCountry = countries.firstWhere(
        (c) => c.iso == 'US',
        orElse: () => countries.first,
      );
      emit(AuthValidation(validationCounter: _validationCounter));
    });
  }

  void submitNewPassword() {
    emit(AuthValidationLoading());
    _newPasswordTouched = true;
    _confirmNewPasswordTouched = true;
    _validationCounter++;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  void updatePassword() {
    emit(AuthLoading());

    emit(AuthLoaded());
  }

  // ============ OTP Verification Methods ============

  /// Start OTP timer (60 seconds / 1 minute)
  void startOtpTimer() {
    emit(AuthValidationLoading());
    _canResendOtp = false;
    _remainingSeconds = 60;
    _otpErrorMessage = null;
    _isOtpBlurred = false;
    _validationCounter++; // Increment to trigger initial emit
    emit(AuthValidation(validationCounter: _validationCounter));

    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _validationCounter++; // Increment counter each tick to trigger rebuild
        emit(AuthValidation(validationCounter: _validationCounter));
      } else {
        _otpTimer?.cancel();
        _canResendOtp = true;
        _validationCounter++;
        emit(AuthValidation(validationCounter: _validationCounter));
      }
    });
  }

  /// Format time for display (MM:SS)
  String formatOtpTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// Resend OTP code
  Future<void> resendOtpCode() async {
    if (!_canResendOtp) return;

    try {
      // Here you can add API call to resend OTP if there's an endpoint
      // For now, just restart the timer
      startOtpTimer();
      emit(AuthValidation(validationCounter: _validationCounter));
    } catch (e) {
      _otpErrorMessage = 'Failed to resend code. Please try again.';
      emit(AuthValidation(validationCounter: _validationCounter));
    }
  }

  /// Clear OTP error message
  void clearOtpError() {
    _otpErrorMessage = null;
    emit(AuthValidation(validationCounter: _validationCounter));
  }

  /// Cleanup OTP timer
  void disposeOtpTimer() {
    _otpTimer?.cancel();
  }

  @override
  Future<void> close() {
    disposeOtpTimer();
    return super.close();
  }
}
