import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/profile/domain/usecase/report_problem_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/report_problem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportProblemCubit extends Cubit<ReportProblemState> {
  final ReportProblemUsecase _reportProblemUsecase;

  ReportProblemCubit(this._reportProblemUsecase)
    : super(ReportProblemInitial());

  bool isSubmitting = false;

  Future<bool> submitReport({
    required String subject,
    required String description,
    required List<String> attachments,
  }) async {
    final normalizedSubject = subject.trim();
    final normalizedDescription = description.trim();

    if (normalizedSubject.isEmpty || normalizedDescription.isEmpty) {
      VxToast.show(message: 'Please fill in all required fields');
      return false;
    }

    if (isClosed) return false;
    emit(ReportProblemLoading());
    isSubmitting = true;

    try {
      final response = await _reportProblemUsecase.reportProblem(
        subject: normalizedSubject,
        description: normalizedDescription,
        attachments: attachments,
      );

      final successMessage =
          response['message'] ?? 'Report submitted successfully';

      isSubmitting = false;
      attachments.clear();
      if (isClosed) return false;
      emit(ReportProblemSuccess(successMessage));
      return true;
    } catch (e) {
      final errorMessage = e.toString();
      VxToast.show(message: errorMessage);
      isSubmitting = false;
      if (isClosed) return false;
      emit(ReportProblemError(errorMessage));
      return false;
    }
  }

  void reset() {
    if (isClosed) return;
    emit(ReportProblemInitial());
  }
}
