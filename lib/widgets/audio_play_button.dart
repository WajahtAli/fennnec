import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../generated/assets.gen.dart';
import '../app/theme/app_colors.dart';
import '../bloc/cubit/audio_player_cubit.dart';
import '../bloc/state/audio_player_state.dart';

class PlayPauseButton extends StatelessWidget {
  final Color? color;
  const PlayPauseButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (_, state) {
        final isStopped =
            state.status == AudioStatus.stopped ||
            state.status == AudioStatus.paused;

        return GestureDetector(
          onTap: () => context.read<AudioPlayerCubit>().toggle(),
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? ColorPalette.primary,
            ),
            child: isStopped
                ? SvgPicture.asset(
                    Assets.icons.play.path,
                    colorFilter: ColorFilter.mode(
                      !isLightTheme(context) ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  )
                : const Icon(Icons.pause, color: Colors.white),
          ),
        );
      },
    );
  }
}
