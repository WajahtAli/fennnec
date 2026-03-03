import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:flutter/material.dart';

class CropAspectRatioSelector extends StatefulWidget {
  final Function(CropType) onSelected;

  const CropAspectRatioSelector({super.key, required this.onSelected});

  static Future<CropType?> show(BuildContext context) {
    return showModalBottomSheet<CropType?>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return CropAspectRatioSelector(
          onSelected: (cropType) {
            Navigator.pop(context, cropType);
          },
        );
      },
    );
  }

  @override
  State<CropAspectRatioSelector> createState() =>
      _CropAspectRatioSelectorState();
}

class _CropAspectRatioSelectorState extends State<CropAspectRatioSelector> {
  late CropType _selectedCropType = CropType.square;

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    final backgroundColor = isLight ? Colors.white : ColorPalette.black;
    final textColor = isLight ? Colors.black87 : Colors.white;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24 + 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Text(
            'Select Crop Format',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),

          // Square option
          _buildCropOption(
            label: 'Square',
            subtitle: '1:1 ratio',
            icon: '⬜',
            isSelected: _selectedCropType == CropType.square,
            onTap: () {
              setState(() {
                _selectedCropType = CropType.square;
              });
            },
            textColor: textColor,
            isLight: isLight,
          ),
          const SizedBox(height: 16),

          // Portrait option
          _buildCropOption(
            label: 'Portrait',
            subtitle: '9:16 ratio',
            icon: '📱',
            isSelected: _selectedCropType == CropType.portrait,
            onTap: () {
              setState(() {
                _selectedCropType = CropType.portrait;
              });
            },
            textColor: textColor,
            isLight: isLight,
          ),
          const SizedBox(height: 32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    widget.onSelected(_selectedCropType);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCropOption({
    required String label,
    required String subtitle,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color textColor,
    required bool isLight,
  }) {
    final borderColor = isSelected
        ? ColorPalette.primary
        : Colors.grey.shade300;
    final backgroundColor = isSelected
        ? ColorPalette.primary.withOpacity(0.1)
        : (isLight ? Colors.grey.shade50 : ColorPalette.black);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            // Icon
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // Selection indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ColorPalette.primary
                      : Colors.grey.shade400,
                  width: isSelected ? 2 : 1.5,
                ),
                color: isSelected ? ColorPalette.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative light dialog version (optional, for simpler UI)
class CropAspectRatioDialog extends StatefulWidget {
  final Function(CropType) onSelected;

  const CropAspectRatioDialog({super.key, required this.onSelected});

  static Future<CropType?> show(BuildContext context) {
    return showDialog<CropType?>(
      context: context,
      builder: (context) {
        return CropAspectRatioDialog(
          onSelected: (cropType) {
            Navigator.pop(context, cropType);
          },
        );
      },
    );
  }

  @override
  State<CropAspectRatioDialog> createState() => _CropAspectRatioDialogState();
}

class _CropAspectRatioDialogState extends State<CropAspectRatioDialog> {
  late CropType _selectedCropType = CropType.square;

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    final textColor = isLight ? Colors.black87 : Colors.white;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Crop Format',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 24),
            _buildDialogOption(
              label: 'Square',
              subtitle: '1:1 aspect ratio - Perfect for profile pictures',
              isSelected: _selectedCropType == CropType.square,
              onTap: () {
                setState(() {
                  _selectedCropType = CropType.square;
                });
              },
              textColor: textColor,
            ),
            const SizedBox(height: 16),
            _buildDialogOption(
              label: 'Portrait',
              subtitle: '9:16 aspect ratio - Perfect for full body photos',
              isSelected: _selectedCropType == CropType.portrait,
              onTap: () {
                setState(() {
                  _selectedCropType = CropType.portrait;
                });
              },
              textColor: textColor,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.primary,
                  ),
                  onPressed: () {
                    widget.onSelected(_selectedCropType);
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogOption({
    required String label,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? ColorPalette.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? ColorPalette.primary.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Radio<CropType>(
              value: label == 'Square' ? CropType.square : CropType.portrait,
              groupValue: _selectedCropType,
              onChanged: (_) {
                onTap();
              },
              activeColor: ColorPalette.primary,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
