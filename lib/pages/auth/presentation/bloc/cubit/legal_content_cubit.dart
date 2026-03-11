import 'package:fennac_app/pages/auth/data/model/legal_content_model.dart';
import 'package:fennac_app/pages/auth/domain/usecases/legal_content_usecase.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/legal_content_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LegalContentCubit extends Cubit<LegalContentState> {
  final LegalContentUsecase _legalContentUsecase;

  LegalContentCubit(this._legalContentUsecase) : super(LegalContentInitial());

  LegalContentModel? legalContentModel;

  Future<void> fetchLegalContents({
    bool? termOfService,
    bool? privacyPolicy,
  }) async {
    emit(LegalContentLoading());

    try {
      final response = await _legalContentUsecase.fetchLegalContents(
        termOfService: termOfService,
        privacyPolicy: privacyPolicy,
      );

      legalContentModel = response;

      if (response.success == true) {
        emit(LegalContentLoaded());
      } else {
        emit(LegalContentError(response.message ?? 'Unable to fetch content'));
      }
    } catch (e) {
      emit(LegalContentError(e.toString()));
    }
  }
}
