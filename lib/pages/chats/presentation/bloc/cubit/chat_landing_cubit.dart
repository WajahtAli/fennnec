import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLandingCubit extends Cubit<ChatLandingState> {
  ChatLandingCubit() : super(ChatLandingInitial());

  int selectedTabIndex = 0;
  SubscriptionStatus subscriptionStatus = SubscriptionStatus.unsubscribed;

  void selectTab(int index) {
    emit(ChatLandingLoading());
    selectedTabIndex = index;
    emit(ChatLandingLoaded());
  }

  void updateSubscriptionStatus(SubscriptionStatus status) {
    emit(ChatLandingLoading());
    subscriptionStatus = status;
    emit(ChatLandingLoaded());
  }
}
