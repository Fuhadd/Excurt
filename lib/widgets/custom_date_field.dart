import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'custom_text_field.dart';

FormBuilderDateTimePicker customDateField(
    String name, IconData prefixIcon, IconData? suffixIcon, String labelText,
    {String? hintText,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function(String?)? onChanged}) {
  return FormBuilderDateTimePicker(
    name: name,
    inputType: InputType.date,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}
