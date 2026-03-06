import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewer extends StatelessWidget {
  final String htmlContent;

  const HtmlViewer({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.body(context);

    return Html(
      data: htmlContent,
      style: {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(baseStyle.fontSize ?? 14),
          fontWeight: baseStyle.fontWeight,
          color: isLightTheme(context) ? Colors.black : Colors.white,
          lineHeight: LineHeight(1.5),
        ),
      },
    );
  }
}
