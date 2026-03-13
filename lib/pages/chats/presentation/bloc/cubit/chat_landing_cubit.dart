import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLandingCubit extends Cubit<ChatLandingState> {
  final ChatRepository _chatRepository;

  ChatLandingCubit(this._chatRepository) : super(ChatLandingInitial());

  int selectedTabIndex = 0;
  SubscriptionStatus subscriptionStatus = SubscriptionStatus.unsubscribed;

  Future<void> fetchChatAndCalls({int? page, int? limit}) async {
    emit(ChatLandingLoading());
    try {
      final response = await _chatRepository.getChatsAndCalls(
        page: page,
        limit: limit,
      );
      emit(ChatLandingLoaded(response));
    } catch (e) {
      emit(ChatLandingError(e.toString()));
    }
  }

  void selectTab(int index) {
    selectedTabIndex = index;
    if (state is ChatLandingLoaded) {
      emit(ChatLandingLoaded((state as ChatLandingLoaded).response));
    } else {
      emit(state);
    }
  }

  void updateSubscriptionStatus(SubscriptionStatus status) {
    subscriptionStatus = status;
    if (state is ChatLandingLoaded) {
      emit(ChatLandingLoaded((state as ChatLandingLoaded).response));
    } else {
      emit(state);
    }
  }
}
