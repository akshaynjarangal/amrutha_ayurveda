import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration(
  BuildContext context, {
  String? hintText,
  bool? filled = true,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.borderColor.withOpacity(0.4),
          fontWeight: FontWeight.w100,
        ),
    fillColor: AppColors.fillColor,
    filled: filled,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    hintText: hintText,
  );
}

InputDecorationTheme dropDownDecoration(){
  return InputDecorationTheme(
    
    hintStyle:  TextStyle(
      color: AppColors.borderColor,
      fontWeight: FontWeight.w100,
    ),
    fillColor: AppColors.fillColor,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 0.85),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );}