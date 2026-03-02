import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/media_container_widget.dart';
import 'package:flutter/material.dart';

class GalleryGridWidget extends StatelessWidget {
  final List<MediaItem> mediaList;
  final Function(BuildContext context, {int? containerIndex}) onShowMediaPicker;
  final bool hasHeader;
  final MediaItem? headerMedia;
  final bool isEditMode;
  final int? selectedIndex;
  final ValueChanged<int>? onMediaTap;

  const GalleryGridWidget({
    super.key,
    required this.mediaList,
    required this.onShowMediaPicker,
    this.hasHeader = false,
    this.headerMedia,
    this.isEditMode = false,
    this.selectedIndex,
    this.onMediaTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        const designWidth = 378.0;
        const designLargeSize = 250.0;
        const designSmallSize = 120.0;
        const designGap = 8.0;
        const designHeaderHeight = 272.0;

        final scale = maxWidth / designWidth;

        final largeSize = designLargeSize * scale;
        final smallSize = designSmallSize * scale;
        final gap = designGap * scale;
        final headerHeight = designHeaderHeight * scale;

        final requiredWidth = largeSize + gap + smallSize;
        final actualScale = maxWidth < requiredWidth
            ? maxWidth / requiredWidth
            : 1.0;

        final adjustedLargeSize = largeSize * actualScale;
        final adjustedSmallSize = smallSize * actualScale;
        final adjustedGap = gap * actualScale;
        final adjustedHeaderHeight = headerHeight * actualScale;

        final offset = hasHeader ? 0 : 0;

        return Column(
          children: [
            if (hasHeader) ...[
              SizedBox(
                width: double.infinity,
                height: adjustedHeaderHeight,
                child: MediaContainerWidget(
                  media: headerMedia,
                  index: -1,
                  width: double.infinity,
                  height: adjustedHeaderHeight,
                  onTapAdd: () async {
                    onShowMediaPicker(context, containerIndex: -1);
                  },
                  isEditMode: false,
                ),
              ),
              SizedBox(height: adjustedGap),
            ],
            // Top row: 1 large + 2 small stacked
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: adjustedLargeSize,
                  width: adjustedLargeSize,
                  child: MediaContainerWidget(
                    media: mediaList.isNotEmpty ? mediaList[0] : null,
                    index: offset,
                    width: adjustedLargeSize,
                    height: adjustedLargeSize,
                    isEditMode: isEditMode,
                    isSelected: selectedIndex == offset,
                    onTapExisting:
                        isEditMode && onMediaTap != null && mediaList.isNotEmpty
                        ? () => onMediaTap!(offset)
                        : null,
                    onTapAdd: () async {
                      onShowMediaPicker(context, containerIndex: offset);
                    },
                  ),
                ),
                SizedBox(width: adjustedGap),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: adjustedSmallSize,
                        child: MediaContainerWidget(
                          media: mediaList.length > 1 ? mediaList[1] : null,
                          index: offset + 1,
                          width: adjustedSmallSize,
                          height: adjustedSmallSize,
                          isEditMode: isEditMode,
                          isSelected: selectedIndex == offset + 1,
                          onTapExisting:
                              isEditMode &&
                                  onMediaTap != null &&
                                  mediaList.length > 1
                              ? () => onMediaTap!(offset + 1)
                              : null,
                          onTapAdd: () async {
                            onShowMediaPicker(
                              context,
                              containerIndex: offset + 1,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: adjustedGap),
                      SizedBox(
                        width: double.infinity,
                        height: adjustedSmallSize,
                        child: MediaContainerWidget(
                          media: mediaList.length > 2 ? mediaList[2] : null,
                          index: offset + 2,
                          width: adjustedSmallSize,
                          height: adjustedSmallSize,
                          isEditMode: isEditMode,
                          isSelected: selectedIndex == offset + 2,
                          onTapExisting:
                              isEditMode &&
                                  onMediaTap != null &&
                                  mediaList.length > 2
                              ? () => onMediaTap!(offset + 2)
                              : null,
                          onTapAdd: () async {
                            onShowMediaPicker(
                              context,
                              containerIndex: offset + 2,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: adjustedGap),
            // Bottom row: 3 small containers with equal widths
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: adjustedSmallSize,
                    child: MediaContainerWidget(
                      media: mediaList.length > 3 ? mediaList[3] : null,
                      index: offset + 3,
                      width: double.infinity,
                      height: adjustedSmallSize,
                      isEditMode: isEditMode,
                      isSelected: selectedIndex == offset + 3,
                      onTapExisting:
                          isEditMode &&
                              onMediaTap != null &&
                              mediaList.length > 3
                          ? () => onMediaTap!(offset + 3)
                          : null,
                      onTapAdd: () async {
                        onShowMediaPicker(context, containerIndex: offset + 3);
                      },
                    ),
                  ),
                ),
                SizedBox(width: adjustedGap),
                Expanded(
                  child: SizedBox(
                    height: adjustedSmallSize,
                    child: MediaContainerWidget(
                      media: mediaList.length > 4 ? mediaList[4] : null,
                      index: offset + 4,
                      width: double.infinity,
                      height: adjustedSmallSize,
                      isEditMode: isEditMode,
                      isSelected: selectedIndex == offset + 4,
                      onTapExisting:
                          isEditMode &&
                              onMediaTap != null &&
                              mediaList.length > 4
                          ? () => onMediaTap!(offset + 4)
                          : null,
                      onTapAdd: () async {
                        onShowMediaPicker(context, containerIndex: offset + 4);
                      },
                    ),
                  ),
                ),
                SizedBox(width: adjustedGap),
                Expanded(
                  child: SizedBox(
                    height: adjustedSmallSize,
                    child: MediaContainerWidget(
                      media: mediaList.length > 5 ? mediaList[5] : null,
                      index: offset + 5,
                      width: double.infinity,
                      height: adjustedSmallSize,
                      isEditMode: isEditMode,
                      isSelected: selectedIndex == offset + 5,
                      onTapExisting:
                          isEditMode &&
                              onMediaTap != null &&
                              mediaList.length > 5
                          ? () => onMediaTap!(offset + 5)
                          : null,
                      onTapAdd: () async {
                        onShowMediaPicker(context, containerIndex: offset + 5);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
