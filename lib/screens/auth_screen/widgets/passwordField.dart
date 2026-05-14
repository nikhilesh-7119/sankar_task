import 'package:flutter/material.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final OutlineInputBorder inputBorder;
  final Color fillColor;
  final double s;

  const PasswordField({
    required this.controller,
    required this.hint,
    required this.inputBorder,
    required this.fillColor,
    required this.s,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: widget.fillColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14 * widget.s,
          vertical: 12 * widget.s,
        ),
        border: widget.inputBorder,
        enabledBorder: widget.inputBorder,
        focusedBorder: widget.inputBorder.copyWith(
          borderSide: BorderSide(color: AppColors.black12Op25),
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => obscure = !obscure),
          icon: obscure == false
              ? const Icon(Icons.visibility, color: AppColors.mutedGrey)
              : const Icon(Icons.visibility_off, color: AppColors.mutedGrey),
          selectedIcon: const Icon(Icons.visibility, color: AppColors.mutedGrey),
          splashRadius: 18,
        ),
      ),
      validator: (v) =>
          (v == null || v.isEmpty) ? AppConstants.passwordRequired : null,
    );
  }
}
