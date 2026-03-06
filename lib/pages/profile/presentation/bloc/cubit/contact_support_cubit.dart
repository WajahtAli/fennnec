import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/profile/domain/usecase/contact_support_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/contact_support_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactSupportCubit extends Cubit<ContactSupportState> {
  final ContactSupportUsecase _contactSupportUsecase;

  ContactSupportCubit(this._contactSupportUsecase)
    : super(ContactSupportInitial());

  bool isSubmitting = false;

  Future<bool> sendSupportMessage({
    required String subject,
    required String message,
  }) async {
    final normalizedSubject = subject.trim();
    final normalizedMessage = message.trim();

    if (normalizedSubject.isEmpty || normalizedMessage.isEmpty) {
      VxToast.show(message: 'Please fill in all fields');
      return false;
    }

    emit(ContactSupportLoading());
    isSubmitting = true;
    try {
      final response = await _contactSupportUsecase.addContactSupport(
        subject: normalizedSubject,
        message: normalizedMessage,
      );

      final successMessage = response['message'] ?? 'Message sent successfully';

      VxToast.show(message: successMessage, icon: Assets.icons.checkGreen.path);

      isSubmitting = false;
      emit(ContactSupportSuccess(successMessage));
      return true;
    } catch (e) {
      final errorMessage = e.toString();
      VxToast.show(message: errorMessage);
      isSubmitting = false;
      emit(ContactSupportError(errorMessage));
      return false;
    }
  }

  void reset() {
    emit(ContactSupportInitial());
  }
}
