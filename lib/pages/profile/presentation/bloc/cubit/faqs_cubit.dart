import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/models/dummy/faq_item_model.dart';
import 'package:fennac_app/pages/profile/data/models/faq_model.dart';
import 'package:fennac_app/pages/profile/domain/usecase/faqs_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/faqs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqsCubit extends Cubit<FaqsState> {
  final FaqsUsecase _faqsUsecase;

  FaqsCubit(this._faqsUsecase) : super(FaqsInitial());

  List<FaqItem> allFaqs = [];

  Future<void> fetchFaqs() async {
    if (isClosed) return;
    emit(FaqsLoading());
    try {
      final response = await _faqsUsecase.fetchFaqs();

      // Parse the response using FaqResponseModel
      final faqResponse = FaqResponseModel.fromJson(response);

      if (faqResponse.data?.faqs != null) {
        allFaqs = faqResponse.data!.faqs!
            .map((faqModel) => faqModel.toFaqItem())
            .toList();
      } else {
        allFaqs = [];
      }

      if (isClosed) return;
      emit(FaqsLoaded(allFaqs));
    } catch (e) {
      final errorMessage = e.toString();
      VxToast.show(message: errorMessage);
      if (isClosed) return;
      emit(FaqsError(errorMessage));
    }
  }

  void searchFaqs(String query) {
    if (isClosed) return;
    if (query.isEmpty) {
      emit(FaqsLoaded(allFaqs));
    } else {
      final filteredFaqs = allFaqs
          .where(
            (item) =>
                item.question.toLowerCase().contains(query.toLowerCase()) ||
                item.answer.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(FaqsLoaded(filteredFaqs));
    }
  }
}
