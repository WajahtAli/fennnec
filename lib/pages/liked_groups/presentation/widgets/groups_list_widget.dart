import 'package:flutter/material.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';
import 'package:fennac_app/reusable_widgets/dynamic_ratio_image_widget.dart';
import 'package:fennac_app/reusable_widgets/custom_video_player.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';

class GroupsListWidget extends StatelessWidget {
  final List<Group> groups;
  const GroupsListWidget({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return const Center(child: Text('No groups found.'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        final images = group.photosVideos ?? [];
        final prompts = group.groupPrompts ?? [];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CustomSizedBox(height: 8),
                if (images.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, imgIdx) {
                        final img = images[imgIdx];
                        return img.toLowerCase().endsWith('.mp4') ||
                                img.toLowerCase().endsWith('.mov') ||
                                img.toLowerCase().endsWith('.m4v') ||
                                img.toLowerCase().endsWith('.avi')
                            ? SizedBox(
                                width: 180,
                                child: CustomVideoPlayer(
                                  videoUrl: img,
                                  autoPlay: false,
                                  looping: false,
                                  showControls: true,
                                  aspectRatio: 1,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : DynamicRatioImageWidget(
                                imageUrl: img,
                                isAsset: img.startsWith('assets/'),
                                height: 180,
                                borderRadius: 16,
                              );
                      },
                    ),
                  ),
                if (prompts.isNotEmpty) ...[
                  const CustomSizedBox(height: 12),
                  ...prompts.map(
                    (p) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.promptTitle ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const CustomSizedBox(height: 4),
                        Text(
                          p.promptAnswer ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const CustomSizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
