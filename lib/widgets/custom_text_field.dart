import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.canReadOnly = false,
    required this.icon,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.onChangedFunction,
    this.color = kMainColor,
    this.isPassword = false,
    this.isPasswordHide = false,
    this.onPasswordTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? initialValue;
  final bool canReadOnly;
  final Color color;
  final bool isPassword;
  final bool isPasswordHide;
  final IconData icon;
  final String labelText;
  final String? hintText;
  final void Function()? onPasswordTap;
  final TextInputType? keyboardType;
  final void Function(String)? onChangedFunction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: canReadOnly,
      initialValue: initialValue,
      controller: controller,
      style: GoogleFonts.openSans(color: color),
      textAlignVertical: TextAlignVertical.center,
      obscureText: isPasswordHide,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: kMainColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kMainColor.withOpacity(0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kMainColor,
          ),
        ),
        focusColor: kMainColor,
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        labelStyle: GoogleFonts.openSans(color: kMainColor),
        hintStyle: GoogleFonts.openSans(color: kMainColor),
        suffixIcon: isPassword
            ? IconButton(
                splashRadius: 24,
                icon: Icon(
                  isPasswordHide
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: kMainColor,
                ),
                onPressed: onPasswordTap,
              )
            : null,
      ),
      onChanged: onChangedFunction,
      keyboardType: keyboardType,
    );
  }
}
