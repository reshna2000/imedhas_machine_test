import 'package:flutter/material.dart';

import '../style/text_style_class.dart';

/// A fully customizable text widget for consistent typography across the app.
class AppText extends StatelessWidget {
  final String text;

  /// Basic styling
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;

  /// Layout behavior
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool softWrap;

  /// Decorations
  final TextDecoration? decoration;
  final Color? decorationColor;

  /// Whether to automatically apply the current theme's text color
  final bool useThemeColor;

  const AppText(
      this.text, {
        super.key,
        this.style,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.letterSpacing,
        this.height,
        this.textAlign,
        this.overflow,
        this.maxLines,
        this.softWrap = true,
        this.decoration,
        this.decorationColor,
        this.useThemeColor = true,  // Changed default to false
      });

  @override
  Widget build(BuildContext context) {
    // Use Styles.roboto20 as the default base style when no style is provided
    final baseStyle = style ?? Styles.roboto20;

    final finalStyle = baseStyle.copyWith(
      color: color ??
          (useThemeColor
              ? Theme.of(context).colorScheme.onBackground
              : baseStyle.color),
      fontSize: fontSize ?? baseStyle.fontSize,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
      height: height ?? baseStyle.height,
      decoration: decoration ?? baseStyle.decoration,
      decorationColor: decorationColor ?? baseStyle.decorationColor,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}