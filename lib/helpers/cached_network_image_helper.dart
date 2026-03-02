import 'package:cached_network_image/cached_network_image.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CachedImageHelper extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? backgroundColor;
  final bool useImageBuilder;
  final double opacity;

  const CachedImageHelper({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius = 0,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
    this.useImageBuilder = true,
    this.opacity = 1.0,
  });

  Widget _baseContainer({Widget? child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _defaultPlaceholder() {
    return _baseContainer(
      child: const Center(child: Icon(Icons.image, color: Colors.grey)),
    );
  }

  Widget _defaultErrorWidget() {
    return _baseContainer(
      child: SizedBox(
        height: 260,
        child: Center(
          child: SvgPicture.asset(
            Assets.icons.fennecLogoWithText.path,
            height: 120,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              ColorPalette.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildContainer(child: placeholder ?? _defaultPlaceholder());
    }

    return _buildImage();
  }

  Widget _buildContainer({required Widget child}) {
    if (radius == 0) {
      return child;
    }
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
  }

  Widget _buildImage() {
    final image = _buildImageContent();

    // Apply opacity if needed
    if (opacity != 1.0) {
      return Opacity(opacity: opacity, child: image);
    }
    return image;
  }

  Widget _buildImageContent() {
    // Check if it's a local asset (starts with 'assets/')
    if (imageUrl!.startsWith('assets/')) {
      return _buildContainer(
        child: Image.asset(
          imageUrl!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultErrorWidget();
          },
        ),
      );
    }

    // It's a network image
    return _buildContainer(
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, __) => placeholder ?? _defaultPlaceholder(),
        errorWidget: (_, __, ___) => errorWidget ?? _defaultErrorWidget(),
      ),
    );
  }
}
