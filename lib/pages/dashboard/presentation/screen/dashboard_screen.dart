import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/pages/homelanding/presentation/screen/home_landing_screen.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/skeletons/home/home_landing_skeleton.dart';
import 'package:fennac_app/utils/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/validators.dart';
import '../../../liked_groups/presentation/bloc/cubit/liked_groups_cubit.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardCubit _dashboardCubit = Di().sl<DashboardCubit>();
  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();
  final CreateAccountCubit _createAccountCubit = Di().sl<CreateAccountCubit>();
  final HomeLandingCubit _homeLandingCubit = Di().sl<HomeLandingCubit>();

  bool _isResolvingDashboardEntryFlow = true;

  Future<void> _configureDashboardEntryFlow() async {
    try {
      await Future.wait([
        _homeLandingCubit.fetchGroupInvitations(),
        _myGroupCubit.fetchGroupById(''),
      ]);

      final hasInvitations = _homeLandingCubit.invitations.isNotEmpty;
      final hasOwnGroup =
          _myGroupCubit.myGroupList?.groupList?.isNotEmpty ?? false;

      if (!mounted) return;

      if (!hasInvitations && hasOwnGroup) {
        _dashboardCubit.changePage(0, const HomeScreen());
      } else {
        _dashboardCubit.changePage(0, const HomeLandingScreen());
        _homeLandingCubit.invitationStatus = hasInvitations
            ? InvitationStatus.pending
            : InvitationStatus.landing;
      }
    } finally {
      if (!mounted) return;
      setState(() => _isResolvingDashboardEntryFlow = false);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_configureDashboardEntryFlow);
    Future.microtask(() => _createAccountCubit.loadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _dashboardCubit,
        builder: (context, state) {
          return Stack(
            children: [
              // Always render the full layout — swap only the content area
              if (_isResolvingDashboardEntryFlow)
                const Center(child: HomeLandingSkeleton())
              else
                IndexedStack(
                  index: _dashboardCubit.selectedIndex,
                  children: _dashboardCubit.screens,
                ),

              // Bottom bar is always present, no flash
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: CustomBottomNavigationBar(
                    items: [
                      BottomNavItem(iconPath: Assets.icons.home.path),
                      BottomNavItem(
                        iconPath: Assets.icons.messageCircle.path,
                        badgeCount: Di()
                            .sl<ChatLandingCubit>()
                            .state
                            .chats
                            .length,
                      ),
                      BottomNavItem(
                        iconPath: Assets.icons.user.path,
                        badgeCount: validateInt(
                          Di()
                                  .sl<LikedGroupsCubit>()
                                  .groupsModel
                                  ?.data
                                  ?.groups
                                  ?.length ??
                              '0',
                        ),
                      ),
                    ],
                    currentIndex: _dashboardCubit.selectedIndex,
                    onTap: _isResolvingDashboardEntryFlow
                        ? (_) {}
                        : _dashboardCubit.changeIndex,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
