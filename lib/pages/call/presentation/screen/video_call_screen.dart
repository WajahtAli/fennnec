import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'audio_call_screen.dart';

@RoutePage()
class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AudioCallScreen();
  }
}
