import 'package:equatable/equatable.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

class ChatLandingState extends Equatable {
  final List<ChatModel> chats;
  final List<ChatPokeModel> pokes;
  final List<CallModel> calls;
  final List<MemberModel> members;
  final bool isLoadingData;
  final String? errorMessage;
  final int selectedTab;
  final SubscriptionStatus subscriptionStatus;
  final String searchQuery;
  final String callSearchQuery;

  const ChatLandingState({
    this.chats = const [],
    this.pokes = const [],
    this.calls = const [],
    this.members = const [],
    this.isLoadingData = false,
    this.errorMessage,
    this.selectedTab = 0,
    this.subscriptionStatus = SubscriptionStatus.unsubscribed,
    this.searchQuery = '',
    this.callSearchQuery = '',
  });

  ChatLandingState copyWith({
    List<ChatModel>? chats,
    List<ChatPokeModel>? pokes,
    List<CallModel>? calls,
    List<MemberModel>? members,
    bool? isLoadingData,
    String? errorMessage,
    int? selectedTab,
    SubscriptionStatus? subscriptionStatus,
    String? searchQuery,
    String? callSearchQuery,
  }) {
    return ChatLandingState(
      chats: chats ?? this.chats,
      pokes: pokes ?? this.pokes,
      calls: calls ?? this.calls,
      members: members ?? this.members,
      isLoadingData: isLoadingData ?? this.isLoadingData,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      callSearchQuery: callSearchQuery ?? this.callSearchQuery,
    );
  }

  @override
  List<Object?> get props => [
    chats,
    pokes,
    calls,
    members,
    isLoadingData,
    errorMessage,
    selectedTab,
    subscriptionStatus,
    searchQuery,
    callSearchQuery,
  ];
}

class ChatLandingInitial extends ChatLandingState {}

class ChatLandingLoading extends ChatLandingState {
  const ChatLandingLoading({
    super.chats,
    super.pokes,
    super.calls,
    super.members,
    super.selectedTab,
    super.isLoadingData,
  });
}

class ChatLandingLoaded extends ChatLandingState {
  const ChatLandingLoaded({
    super.chats,
    super.pokes,
    super.calls,
    super.members,
    super.selectedTab,
    super.isLoadingData,
  });
}

class ChatLandingError extends ChatLandingState {
  const ChatLandingError({
    super.errorMessage,
    super.chats,
    super.pokes,
    super.calls,
    super.members,
    super.selectedTab,
  });
}
