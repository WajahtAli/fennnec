import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrHelper extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  final Color? backgroundColor;

  const QrHelper({
    super.key,
    required this.data,
    this.size = 224.0,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: size,
      backgroundColor: backgroundColor ?? Colors.transparent,
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: color ?? Colors.white,
      ),
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: color ?? Colors.white,
      ),
    );
  }
}
