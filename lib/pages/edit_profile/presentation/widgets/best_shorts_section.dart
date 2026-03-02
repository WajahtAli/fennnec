import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/edit_profile/presentation/widgets/profile_section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BestShortsSection extends StatelessWidget {
  final List<String> bestShorts;
  final VoidCallback onEditTap;

  const BestShortsSection({
    super.key,
    required this.bestShorts,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSectionWrapper(
      title: 'Your Best Shots',
      child: bestShorts.isEmpty ? _buildEmptyGrid() : _buildImageGrid(),
    );
  }

  Widget _buildEmptyGrid() {
    final dummyImages = [
      Assets.dummy.a1.path,
      // Assets.dummy.a2.path,
      // Assets.dummy.a3.path,
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dummyImages.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _ImageItem(
          imagePath: dummyImages[index],
          isNetwork: false,
          onEditTap: onEditTap,
        );
      },
    );
  }

  Widget _buildImageGrid() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bestShorts.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _ImageItem(
          imagePath: bestShorts[index],
          isNetwork: true,
          onEditTap: onEditTap,
        );
      },
    );
  }
}

class _ImageItem extends StatelessWidget {
  final String imagePath;
  final bool isNetwork;
  final VoidCallback onEditTap;

  const _ImageItem({
    required this.imagePath,
    required this.isNetwork,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkTheme(context)
                    ? Colors.grey[800]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: isNetwork
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 400,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 400,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      imagePath,
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
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
