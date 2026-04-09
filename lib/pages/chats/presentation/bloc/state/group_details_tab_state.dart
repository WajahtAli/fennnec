import 'package:equatable/equatable.dart';

class GroupDetailsTabState extends Equatable {
  final int selectedTab;

  const GroupDetailsTabState({this.selectedTab = 0});

  GroupDetailsTabState copyWith({int? selectedTab}) {
    return GroupDetailsTabState(selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  List<Object?> get props => [selectedTab];
}
