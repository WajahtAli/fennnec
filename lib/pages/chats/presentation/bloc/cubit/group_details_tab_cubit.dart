import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/group_details_tab_state.dart';

class GroupDetailsTabCubit extends Cubit<GroupDetailsTabState> {
  GroupDetailsTabCubit() : super(const GroupDetailsTabState());

  void selectTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }
}
