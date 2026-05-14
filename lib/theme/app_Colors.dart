import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color.fromARGB(255, 236, 233, 233);
  static const accent = Color.fromARGB(255, 240, 143, 143);
  static const border = Color(0xFFEAE6E2);
  static const cardBg = Color.fromARGB(255, 255, 247, 253);

  // State colors
  static const yes = Color(0xFFBFF2C1);
  static const no = Color(0xFFF7C1C1);
  static const maybe = Color(0xFFF7E2A5);
  static const pending = Color(0xFFD6DBE8);

  //checkList colors
  static const urgencyHigh = Color(0xFFF7C1C1);
  static const urgencyMedium = Color(0xFFF7E2A5);
  static const urgencyLow = Color(0xFFBFF2C1);

  // Literal colors collected from the codebase
  static const white = Colors.white;
  static const black = Colors.black;
  static const cardCream = Color(0xFFFDF6F2);
  static const textDark = Color(0xFF1B1B1B);
  static const mutedGrey = Color(0xFF6B6B6B);
  static const heartPink = Color.fromARGB(255, 243, 163, 163);
  static const subtitleGrey = Color.fromARGB(255, 59, 59, 59);
  static const footerGrey = Color.fromARGB(255, 41, 40, 40);
  static const buttonShadowPink = Color.fromARGB(255, 248, 134, 134);
  static const welcomeSubtitle = Color.fromARGB(255, 31, 31, 31);
  static const tabLabelPink = Color.fromARGB(255, 233, 105, 105);
  static const tabUnselectedGrey = Color.fromARGB(255, 60, 60, 60);

  // Translucent variants (non-const due to withValues)
  static final black12Op05 = Colors.black12.withValues(alpha: 0.05);
  static final black12Op15 = Colors.black12.withValues(alpha: 0.15);
  static final black12Op25 = Colors.black12.withValues(alpha: 0.25);
  static final blackOp03 = Colors.black.withValues(alpha: 0.03);
  static final blackOp05 = Colors.black.withValues(alpha: 0.05);
  static final whiteOp4 = Colors.white.withValues(alpha: 0.4);
  static final whiteOp6 = Colors.white.withValues(alpha: 0.6);
  static final whiteOp7 = Colors.white.withValues(alpha: 0.7);
  static final accentOp25 = accent.withValues(alpha: 0.25);
  static final softCirclePinkOp25 =
      const Color.fromARGB(255, 240, 143, 143).withValues(alpha: 0.25);
}
