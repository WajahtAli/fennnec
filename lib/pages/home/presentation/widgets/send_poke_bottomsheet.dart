import 'package:cached_network_image/cached_network_image.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/widgets/prompt_audio_row.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/widgets/custom_bottom_sheet.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../buy_poke/presentation/bloc/cubit/poke_cubit.dart';

class SendPokeBottomSheet extends StatefulWidget {
  final String? image;
  final PokeType pokeType;
  final String? targetId;
  final String? promptTitle;
  final String? promptAnswer;
  final String? audioPath;
  final String? audioDuration;
  final List<double>? waveformData;

  const SendPokeBottomSheet({
    super.key,
    this.image,
    required this.pokeType,
    this.targetId,
    this.promptTitle,
    this.promptAnswer,
    this.audioPath,
    this.audioDuration,
    this.waveformData,
  });

  @override
  State<SendPokeBottomSheet> createState() => _SendPokeBottomSheetState();
}

class _SendPokeBottomSheetState extends State<SendPokeBottomSheet> {
  late final TextEditingController _messageController;
  late final Member? _selectedProfileSnapshot;
  final _homeCubit = Di().sl<HomeCubit>();
  final _pokeCubit = Di().sl<PokeCubit>();

  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _blurNotifier = ValueNotifier(false);
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _selectedProfileSnapshot = _cloneMember(_homeCubit.selectedProfile);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendPoke() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _errorMessage = null);

    try {
      final selectedProfile =
          _selectedProfileSnapshot ?? _homeCubit.selectedProfile;
      final toUserId = selectedProfile?.id;
      if (toUserId == null) {
        VxToast.show(message: 'No profile selected');
        return;
      }

      final targetType = _resolveTargetType();
      final targetId = _resolveTargetId(selectedProfile);

      if ((targetType == 'photo' || targetType == 'prompt') &&
          (targetId == null || targetId.isEmpty)) {
        VxToast.show(message: 'Could not determine the selected poke target');

        return;
      }

      await _pokeCubit.sendPoke(
        toUserId: toUserId,
        targetType: targetType,
        targetId: targetId,
        message: _messageController.text.trim(),
      );

      if (context.mounted) {
        Navigator.pop(context);
        await CustomBottomSheet.show(
          blurNotifier: _blurNotifier,
          context: context,
          title: 'Poke Sent!',
          description: "Let's see if they poke back.",
          buttonText: 'Done',
          icon: AnimatedBackgroundContainer(
            icon: Assets.icons.checkGreen.path,
            isPng: true,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  Member? _cloneMember(Member? profile) {
    if (profile == null) {
      return null;
    }

    return profile.copyWith(
      interests: profile.interests == null
          ? null
          : List<String>.from(profile.interests!),
      images: profile.images == null
          ? null
          : List<String>.from(profile.images!),
      bestShorts: profile.bestShorts == null
          ? null
          : List<String>.from(profile.bestShorts!),
      prompts: profile.prompts == null
          ? null
          : List<GroupPrompt>.from(profile.prompts!),
      lifestyle: profile.lifestyle == null
          ? null
          : List<String>.from(profile.lifestyle!),
    );
  }

  String _resolveTargetType() {
    switch (widget.pokeType) {
      case PokeType.floating:
        return 'profile';
      case PokeType.image:
        return 'photo';
      case PokeType.text:
      case PokeType.audio:
        return 'prompt';
    }
  }

  String? _resolveTargetId(dynamic profile) {
    if (widget.targetId != null && widget.targetId!.isNotEmpty) {
      return widget.targetId;
    }

    switch (widget.pokeType) {
      case PokeType.image:
        final image = widget.image;
        if (image == null || image.isEmpty) {
          return null;
        }
        final index = profile?.bestShorts?.indexOf(image) ?? -1;
        return index >= 0 ? index.toString() : null;
      case PokeType.text:
      case PokeType.audio:
        final prompts = profile?.prompts;
        if (prompts == null || prompts.isEmpty) {
          return null;
        }

        for (final prompt in prompts) {
          if (prompt.promptTitle == widget.promptTitle &&
              prompt.promptAnswer == widget.promptAnswer) {
            return prompt.id;
          }
        }
        return null;
      case PokeType.floating:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        width: getWidth(context),
        height: 583,
        decoration: BoxDecoration(
          gradient: isLightTheme(context)
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF16003F), ColorPalette.black],
                ),
          color: isLightTheme(context) ? Colors.white : null,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPokeContent(
                    context,
                    _selectedProfileSnapshot ?? _homeCubit.selectedProfile,
                  ),
                  const CustomSizedBox(height: 32),
                  CustomLabelTextField(
                    label: 'Add a short message',
                    controller: _messageController,
                    hintText: 'Type here...',
                    filled: false,
                    maxLines: 2,
                    labelColor: isLightTheme(context)
                        ? Colors.black
                        : Colors.white,
                    labelStyle: AppTextStyles.inputLabel(context),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a message to send a poke.';
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? ColorPalette.textGrey
                          : ColorPalette.primary.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text:
                                'Pokes let you stand out! Send one to show interest and invite someone to chat privately.',
                            style: AppTextStyles.label(context).copyWith(
                              color: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            Assets.icons.cancel.path,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomSizedBox(height: 24),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  BlocBuilder(
                    bloc: _pokeCubit,
                    builder: (context, state) {
                      return CustomElevatedButton(
                        icon: state is PokeLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: Lottie.asset(
                                  Assets.animations.loadingSpinner,
                                ),
                              )
                            : SizedBox.shrink(),
                        onTap: _sendPoke,
                        text: state is PokeLoading ? '' : 'Send Poke',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPokeContent(BuildContext context, dynamic profile) {
    final promptTitle =
        widget.promptTitle ??
        profile?.promptTitle ??
        'A perfect weekend for me looks like...';
    final promptAnswer =
        widget.promptAnswer ??
        profile?.promptAnswer ??
        'A morning hike, brunch with friends, and a movie marathon.';
    final audioPath = widget.audioPath ?? Assets.dummy.audio.group;
    final audioDuration = widget.audioDuration ?? '00:16';
    final displayName = profile?.name ?? profile?.firstName ?? 'User';
    final displayAge = profile?.age != null ? ', ${profile?.age}' : '';

    switch (widget.pokeType) {
      case PokeType.floating:
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child:
                        (widget.image ?? profile?.images?.first ?? '')
                            .startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl:
                                widget.image ?? profile?.images?.first ?? '',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.image ?? profile?.images?.first ?? '',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.primary,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      AppEmojis.pointingRight,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                  ),
                ),
              ],
            ),

            const CustomSizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  textAlign: TextAlign.center,
                  text: '$displayName$displayAge',
                  style: AppTextStyles.h3(context).copyWith(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                SvgPicture.asset(
                  Assets.icons.verified.path,
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ],
        );

      case PokeType.audio:
        return Transform.rotate(
          angle: -0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 12,
                  top: 0,
                  bottom: 12,
                ),
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? ColorPalette.textGrey
                      : ColorPalette.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: promptTitle,
                          style: AppTextStyles.subHeading(context).copyWith(
                            color: isLightTheme(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        const CustomSizedBox(height: 12),
                        PromptAudioRow(
                          audioPath: audioPath,
                          duration: audioDuration,
                          waveformData: widget.waveformData,
                          height: 64,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          backgroundColor: isLightTheme(context)
                              ? Colors.white
                              : ColorPalette.secondary,
                          playButtonColor: ColorPalette.primary,
                          waveformColor: isLightTheme(context)
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.primary,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Text(
                          AppEmojis.pointingRight,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case PokeType.text:
        return Transform.rotate(
          angle: -0.05,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 130,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? ColorPalette.textGrey
                          : ColorPalette.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: promptTitle,
                          style: AppTextStyles.subHeading(context).copyWith(
                            color: isLightTheme(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        const CustomSizedBox(height: 12),
                        AppText(
                          text: promptAnswer,
                          style: AppTextStyles.h3(context).copyWith(
                            color: isLightTheme(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primary,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        AppEmojis.pointingRight,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      case PokeType.image:
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Transform.rotate(
                  angle: -0.05,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: ColorPalette.primary, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child:
                          (widget.image ?? profile?.images?.first ?? '')
                              .startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl:
                                  widget.image ?? profile?.images?.first ?? '',
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              widget.image ?? profile?.images?.first ?? '',
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.primary,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    AppEmojis.pointingRight,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(context),
                  ),
                ),
              ],
            ),
            const CustomSizedBox(height: 16),
            AppText(
              textAlign: TextAlign.center,
              text: '$displayName$displayAge',
              style: AppTextStyles.h3(context).copyWith(
                color: isLightTheme(context) ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
    }
  }
}
