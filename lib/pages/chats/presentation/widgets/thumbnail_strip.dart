import 'package:fennac_app/pages/chats/data/models/message_model.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/thumbnail_tile.dart';
import 'package:flutter/material.dart';

import '../../../../core/di_container.dart';
import '../bloc/cubit/message_cubit.dart';

class ThumbnailStrip extends StatelessWidget {
  final List<MessageModel> messages;
  final int selectedIndex;
  final Function(int) onMessageSelected;

  const ThumbnailStrip({
    super.key,
    required this.messages,
    required this.selectedIndex,
    required this.onMessageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black.withValues(alpha: 0.3),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: Di().sl<MessageCubit>().getMedias().length,
        itemBuilder: (context, index) {
          return ThumbnailTile(
            message: Di().sl<MessageCubit>().getMedias()[index],
            isSelected: index == selectedIndex,
            onTap: () => onMessageSelected(index),
          );
        },
      ),
    );
  }
}
