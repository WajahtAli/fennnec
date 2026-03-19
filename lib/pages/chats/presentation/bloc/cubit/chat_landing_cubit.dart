import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';

class ChatLandingCubit extends Cubit<ChatLandingState> {
  final ChatRepository _chatRepository = Di().sl<ChatRepository>();

  ChatLandingCubit() : super(const ChatLandingState());

  void selectTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void updateSubscriptionStatus(SubscriptionStatus status) {
    emit(state.copyWith(subscriptionStatus: status));
  }

  Future<void> fetchChatsAndCalls({int page = 1, int limit = 20}) async {
    emit(state.copyWith(isLoadingData: true, errorMessage: null));
    try {
      final response = await _chatRepository.getChatsAndCalls(page: page, limit: limit);
      if (response.success) {
        emit(state.copyWith(
          isLoadingData: false,
          chats: response.data.chats,
          calls: response.data.calls,
        ));
      } else {
        emit(state.copyWith(isLoadingData: false, errorMessage: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingData: false, errorMessage: e.toString()));
    }
  }
}
