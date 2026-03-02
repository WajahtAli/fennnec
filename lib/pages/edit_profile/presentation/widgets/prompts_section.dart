import 'dart:math' as math;

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/data/model/prompt_model.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/profile_section_wrapper.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PromptsSection extends StatelessWidget {
  final List<Prompt> prompts;
  final Function(Prompt, bool) onEditTap;

  const PromptsSection({
    super.key,
    required this.prompts,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWrapper(
      title: 'Prompts',
      child: prompts.isEmpty ? _buildEmptyPrompts() : _buildPromptsList(),
    );
  }

  Widget _buildEmptyPrompts() {
    return _PromptCard(
      prompt: Prompt(
        promptAnswer: Assets.dummy.audio.group,
        duration: 16,
        type: "audio",
        promptTitle: "Prompt Title",
        waves: List.generate(100, (index) => 0.2 * math.Random().nextDouble()),
      ),
      onEditTap: () => onEditTap(
        Prompt(
          promptAnswer: Assets.dummy.audio.group,
          duration: 16,
          type: "audio",
          promptTitle: "Prompt Title",
          waves: List.generate(
            100,
            (index) => 0.2 * math.Random().nextDouble(),
          ),
        ),
        false,
      ),
    );
  }

  Widget _buildPromptsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prompts.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _PromptCard(
            prompt: prompts[index],
            onEditTap: () => onEditTap(prompts[index], true),
          ),
        );
      },
    );
  }
}

class _PromptCard extends StatelessWidget {
  final Prompt prompt;
  final VoidCallback onEditTap;

  const _PromptCard({required this.prompt, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    final String promptTitle = prompt.promptTitle?.toString() ?? '';
    final String promptAnswer = prompt.promptAnswer?.toString() ?? '';
    final String promptType = prompt.type?.toString() ?? 'text';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: .2),
                  ColorPalette.black.withValues(alpha: .2),
                ],
              )
            : null,
        color: isLightTheme(context) ? ColorPalette.textGrey : null,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(promptTitle, style: AppTextStyles.subHeading(context)),
              const SizedBox(height: 14),
              if (promptType == 'audio' && promptAnswer.isNotEmpty)
                PromptAudioRow(
                  audioPath: promptAnswer,
                  duration: prompt.duration.toString(),
                  waveformData: prompt.waves ?? [],
                )
              else
                Text(
                  promptAnswer,
                  style: AppTextStyles.h3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.icons.edit.path,
                  height: 16,
                  width: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
