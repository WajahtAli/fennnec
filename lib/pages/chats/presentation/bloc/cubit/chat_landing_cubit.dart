import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/chats/data/repository/chat_repository.dart';

class ChatLandingCubit extends Cubit<ChatLandingState> {
  final ChatRepository _chatRepository = Di().sl<ChatRepository>();
  String _searchQuery = '';
  List<ChatModel> _filteredChats = const [];

  ChatLandingCubit() : super(const ChatLandingState());

  List<ChatModel> get filteredChats => _filteredChats;
  bool get isSearching => _searchQuery.trim().isNotEmpty;

  void selectTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void updateSubscriptionStatus(SubscriptionStatus status) {
    emit(state.copyWith(subscriptionStatus: status));
  }

  void onSearchChanged(String query) {
    _searchQuery = query;
    _applyChatFilter(state.chats);
    emit(state.copyWith(searchQuery: _searchQuery));
  }

  Future<void> fetchChatsAndCalls({int page = 1, int limit = 20}) async {
    emit(state.copyWith(isLoadingData: true, errorMessage: null));
    try {
      final response = await _chatRepository.getChatsAndCalls(
        page: page,
        limit: limit,
      );
      if (response.success) {
        final nextState = state.copyWith(
          isLoadingData: false,
          chats: response.data.chats,
          calls: response.data.calls,
        );
        _applyChatFilter(nextState.chats);
        emit(nextState);
      } else {
        emit(
          state.copyWith(isLoadingData: false, errorMessage: response.message),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoadingData: false, errorMessage: e.toString()));
    }
  }

  void _applyChatFilter(List<ChatModel> chats) {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      _filteredChats = const [];
      return;
    }

    _filteredChats = chats.where((chat) {
      if (chat.name.toLowerCase().contains(normalizedQuery)) {
        return true;
      }

      return chat.members?.any(
            (member) => member.name.toLowerCase().contains(normalizedQuery),
          ) ??
          false;
    }).toList();
  }
}
