




import 'package:flutter/material.dart';

import '../../../../core/size.dart';
import '../../../../resourses/widgets/app_text.dart';
import '../../../../resourses/widgets/text_field_widget.dart';


class AppFieldWithLabel extends StatefulWidget {
  final bool? isObscure;
  final TextInputType? inputType;
  final bool isDatePicker;
  final String label;
  final String? hintText;
  final String ? Function(String?)? validator;
  final TextEditingController controller;

  const AppFieldWithLabel({
    super.key,
    this.isDatePicker = false,
    this.isObscure,
    required this.label,
    this.inputType,
    this.hintText,
    required this.controller, this.validator,
  });

  @override
  State<AppFieldWithLabel> createState() => _AppFieldWithLabelState();
}

class _AppFieldWithLabelState extends State<AppFieldWithLabel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(widget.label),
        setHeight(4),
        AppTextField(
          obscureText: widget.isObscure??false,
          validator: widget.validator,
          textInputType: widget.inputType,
          hintText: widget.hintText,
          isDatePicker: widget.isDatePicker,
          controller: widget.controller,
        ),
      ],
    );
  }
}

