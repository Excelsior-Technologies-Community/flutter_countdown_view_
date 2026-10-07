import 'package:flutter/material.dart';

class CountdownConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color labelColor;
  final Color separatorColor;

  final double borderRadius;
  final double boxWidth;
  final double boxHeight;

  final double numberFontSize;
  final double labelFontSize;

  final FontWeight numberFontWeight;
  final FontWeight labelFontWeight;

  final bool showDays;
  final bool showHours;
  final bool showMinutes;
  final bool showSeconds;

  final bool showLabels;
  final bool showSeparators;

  const CountdownConfig({
    this.backgroundColor = const Color(0xFF1E1E2C),
    this.textColor = Colors.white,
    this.labelColor = const Color(0xFFB8B8C7),
    this.separatorColor = Colors.white,

    this.borderRadius = 12,
    this.boxWidth = 70,
    this.boxHeight = 80,

    this.numberFontSize = 28,
    this.labelFontSize = 11,

    this.numberFontWeight = FontWeight.bold,
    this.labelFontWeight = FontWeight.w500,

    this.showDays = true,
    this.showHours = true,
    this.showMinutes = true,
    this.showSeconds = true,

    this.showLabels = true,
    this.showSeparators = true,
  });
}