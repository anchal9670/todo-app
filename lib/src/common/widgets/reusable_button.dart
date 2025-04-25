import 'package:flutter/material.dart';
import 'package:todoapp/src/res/colors.dart';

class ReusableButton extends StatelessWidget {
  final double? width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final bool isLoading;
  const ReusableButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    required this.text,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          disabledBackgroundColor: AppColors.primary,
        ),
        onPressed: isLoading ? null : onPressed,
        child: Text(
          isLoading ? 'Loading...' : text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
