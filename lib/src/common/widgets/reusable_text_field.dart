import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final bool? obscureText;
  final bool? isEnable;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixIcon;
  final Function()? onSuffixIconTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.readOnly,
    this.obscureText,
    this.isEnable,
    this.onChanged,
    this.suffixIcon,
    this.suffixText,
    this.prefixIcon,
    this.onSuffixIconTap,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText ?? false,
        enabled: isEnable ?? true,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 14),
          hintText: "Enter $hintText",
          alignLabelWithHint: true,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black87),
          ),
          prefixIcon: prefixIcon,
          suffixIcon:
              suffixIcon != null
                  ? GestureDetector(onTap: onSuffixIconTap, child: suffixIcon)
                  : null,
          suffix:
              suffixText != null && suffixText!.isNotEmpty
                  ? Text(
                    suffixText!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
