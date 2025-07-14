import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static const body = TextStyle(fontSize: 16, color: AppColors.text);
  static const caption = TextStyle(fontSize: 14, color: AppColors.text);
}
