import 'package:equatable/equatable.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

class ChatLandingState extends Equatable {
  final List<ChatModel> chats;
  final List<CallModel> calls;
  final bool isLoadingData;
  final String? errorMessage;
  final int selectedTab;
  final SubscriptionStatus subscriptionStatus;

  const ChatLandingState({
    this.chats = const [],
    this.calls = const [],
    this.isLoadingData = false,
    this.errorMessage,
    this.selectedTab = 0,
    this.subscriptionStatus = SubscriptionStatus.unsubscribed,
  });

  ChatLandingState copyWith({
    List<ChatModel>? chats,
    List<CallModel>? calls,
    bool? isLoadingData,
    String? errorMessage,
    int? selectedTab,
    SubscriptionStatus? subscriptionStatus,
  }) {
    return ChatLandingState(
      chats: chats ?? this.chats,
      calls: calls ?? this.calls,
      isLoadingData: isLoadingData ?? this.isLoadingData,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
    );
  }

  @override
  List<Object?> get props => [
        chats,
        calls,
        isLoadingData,
        errorMessage,
        selectedTab,
        subscriptionStatus,
      ];
}

class ChatLandingInitial extends ChatLandingState {}

class ChatLandingLoading extends ChatLandingState {
  const ChatLandingLoading({super.chats, super.calls, super.selectedTab, super.isLoadingData});
}

class ChatLandingLoaded extends ChatLandingState {
  const ChatLandingLoaded({super.chats, super.calls, super.selectedTab, super.isLoadingData});
}

class ChatLandingError extends ChatLandingState {
  const ChatLandingError({super.errorMessage, super.chats, super.calls, super.selectedTab});
}
