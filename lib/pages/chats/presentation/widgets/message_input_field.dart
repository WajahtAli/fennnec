import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/attachment_widget.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/recording_audio_widget.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'media_selection_widget.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({super.key});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final MessageCubit _messageCubit = Di().sl<MessageCubit>();
  final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();

  @override
  void initState() {
    _messageCubit.messageController.addListener(() {
      _messageCubit.updateFieldHaveText(
        _messageCubit.messageController.text.trim().isNotEmpty,
      );
    });
    super.initState();
  }

  void _sendMessage() {
    _messageCubit.sendTextMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _imagePickerCubit,
      builder: (context, imageState) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: ColorPalette.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: BlocBuilder<MessageCubit, MessageState>(
            bloc: _messageCubit,
            builder: (context, state) {
              return _messageCubit.isRecordingAudio
                  ? RecordingAudioWidget()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _messageCubit.toggleAttachmentPanel();
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorPalette.primary,
                                        ColorPalette.primary.withValues(
                                          alpha: 0.6,
                                        ),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorPalette.primary.withValues(
                                          alpha: 0.35,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    _messageCubit.showAttachmentPanel
                                        ? Assets.icons.cancel.path
                                        : Assets.icons.plus.path,
                                  ),
                                ),
                              ),
                              const CustomSizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLightTheme(context)
                                        ? Colors.white.withValues(alpha: 0.15)
                                        : Colors.black.withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: ColorPalette.white.withValues(
                                        alpha: 0.06,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _messageCubit.messageController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autocorrect: true,
                                    keyboardAppearance: Brightness.dark,
                                    onTap: () {
                                      _messageCubit.toggleAttachmentPanel(
                                        close: true,
                                      );
                                    },
                                    onSubmitted: (_) => _sendMessage(),
                                    style: AppTextStyles.body(context).copyWith(
                                      color: isLightTheme(context)
                                          ? ColorPalette.black
                                          : ColorPalette.white,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Type a message...',
                                      hintStyle: AppTextStyles.body(context)
                                          .copyWith(
                                            color: isLightTheme(context)
                                                ? ColorPalette.black
                                                : ColorPalette.white.withValues(
                                                    alpha: 0.5,
                                                  ),
                                            fontSize: 15,
                                          ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const CustomSizedBox(width: 12),
                              GestureDetector(
                                onTap: _messageCubit.isTextInputEmpty()
                                    ? () {
                                        _messageCubit.toggleRecordingAudio();
                                      }
                                    : _sendMessage,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !_messageCubit.isTextInputEmpty()
                                        ? ColorPalette.primary
                                        : Colors.black.withValues(alpha: 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    _messageCubit.isTextInputEmpty()
                                        ? Assets.icons.mic.path
                                        : Assets.icons.send.path,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: _messageCubit.showAttachmentPanel == true
                              ? const Column(
                                  key: ValueKey('inline-attachment-panel'),
                                  children: [
                                    CustomSizedBox(height: 12),
                                    AttachmentWidget(),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                        if (imageState is ImagePickerLoaded &&
                            imageState.mediaList != null &&
                            imageState.mediaList!.isNotEmpty)
                          MediaSelectionWidget(
                            key: const ValueKey('media-selection-widget'),
                          ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}
