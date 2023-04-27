import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

FormBuilderTextField customTextField(
    String name, IconData prefixIcon, IconData? suffixIcon, String labelText,
    {String? hintText,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function(String?)? onChanged}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: CustomColors.mainPinkColor,
    name: name,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: const TextStyle(color: CustomColors.mainPinkColor),
      fillColor: CustomColors.mainPinkColor,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.mainPinkColor)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
        color: CustomColors.blackIconColor,
      ),
      // prefixIconColor: Colors.red,
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
        color: CustomColors.blackIconColor,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}
