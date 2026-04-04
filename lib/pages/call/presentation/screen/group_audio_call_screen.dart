import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/call/presentation/widgets/active_user_tile.dart';
import 'package:fennac_app/pages/call/presentation/widgets/audio_participant_tile.dart';
import 'package:fennac_app/pages/call/presentation/widgets/call_controls_row.dart';
import 'package:fennac_app/pages/call/presentation/widgets/call_header_widget.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GroupAudioCallScreen extends StatefulWidget {
  final Group group;
  final bool isVideoCall;
  const GroupAudioCallScreen({
    super.key,
    required this.group,
    this.isVideoCall = false,
  });

  @override
  State<GroupAudioCallScreen> createState() => _GroupAudioCallScreenState();
}

class _GroupAudioCallScreenState extends State<GroupAudioCallScreen> {
  // Mock duration for demo
  final Duration _duration = const Duration(minutes: 17, seconds: 42);

  @override
  Widget build(BuildContext context) {
    // Grid members
    final gridMembers = widget.group.members;

    // Dummy "You" user for visualization
    final currentUser = Member(
      id: 'me',
      name: 'Me',
      firstName: 'You',
      age: 25,
      bio: '',
      coverImage: Assets.images.girlsGroup.path,
      gender: '',
      orientation: '',
      pronouns: '',
      location: '',
      distance: '',
      education: '',
      profession: '',
      promptTitle: '',
      promptAnswer: '',
      lifestyle: [],
      interests: [],
      images: [],
    );

    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  CallHeaderWidget(),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.72,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                        itemCount: gridMembers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return AudioParticipantTile(
                            profile: gridMembers![index],
                            isVideoCall: widget.isVideoCall,
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 140.h),
                ],
              ),

              Positioned(
                left: 20,
                bottom: 110.h,
                child: ActiveUserTile(user: currentUser),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 30.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CallControlsRow(
                    onEndCall: () {
                      context.router.pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
