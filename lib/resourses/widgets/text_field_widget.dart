import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../style/colors_class.dart';
import '../style/text_style_class.dart';

class AppTextField extends StatefulWidget {
  final Color? bgColor;
  final bool obscureText;
  final TextStyle? hintTextStyle;
  final String? name;
  final String? hintText;
  final double? borderRadius;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final String? label;
  final Widget? labelWidget;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onSubmitted;
  final VoidCallback? function;
  final FocusNode? focusNode;
  final bool floating;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool suffixDropDown;
  final VoidCallback? onTapFunction;
  final int? maxLine;
  final int? maxLength;
  final EdgeInsetsGeometry? edgeInsets;
  final EdgeInsetsGeometry? padding;
  final Widget? iconWithFunction;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final bool isFilled;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool isBorderNeeded;
  final bool isPrefixTextNeeded;
  final bool enabled;
  final String? counterText;
  final EdgeInsetsGeometry? contentPadding;
  final Color? enabledBorderColor;
  final Color? textColor;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool expands;
  final bool isDatePicker;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppTextField({
    super.key,
    this.bgColor,
    this.obscureText = false,
    this.hintTextStyle,
    this.name,
    this.hintText,
    this.borderRadius,
    this.focusedBorderColor,
    this.cursorColor,
    this.label,
    this.labelWidget,
    this.controller,
    this.textInputType,
    this.onSubmitted,
    this.function,
    this.focusNode,
    this.floating = false,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.textInputAction,
    this.readOnly = false,
    this.suffixDropDown = false,
    this.onTapFunction,
    this.maxLine,
    this.maxLength,
    this.edgeInsets,
    this.padding,
    this.iconWithFunction,
    this.prefixWidget,
    this.suffixIcon,
    this.isFilled = false,
    this.fillColor,
    this.borderColor = Palette.greyLight,
    this.textStyle,
    this.isBorderNeeded = true,
    this.isPrefixTextNeeded = false,
    this.enabled = true,
    this.counterText,
    this.contentPadding,
    this.enabledBorderColor,
    this.textColor,
    this.onChanged,
    this.validator,
    this.expands = false,
    this.isDatePicker = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _passwordVisible;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Palette.kPrimary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Palette.kPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        widget.controller?.text = formattedDate;
        if (widget.onChanged != null) {
          widget.onChanged!(formattedDate);
        }
      });
    }
  }

  void _handleDateInput(String value) {
    if (value.length == 10) {
      try {
        final date = DateFormat('dd/MM/yyyy').parseStrict(value);
        setState(() {
          _selectedDate = date;
        });
      } catch (e) {
        // Invalid date format
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      margin: widget.edgeInsets ?? EdgeInsets.zero,
      child: TextFormField(
        onFieldSubmitted: widget.onSubmitted,
        expands: widget.expands,
        enabled: widget.enabled,
        cursorColor: widget.cursorColor ?? Palette.kPrimary,
        readOnly: widget.isDatePicker ? false : widget.readOnly,
        validator: widget.validator,
        onTap: widget.isDatePicker ? null : widget.onTapFunction,
        inputFormatters: widget.isDatePicker
            ? [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
          LengthLimitingTextInputFormatter(10),
          _DateInputFormatter(),
        ]
            : widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.isDatePicker
            ? TextInputType.number
            : widget.textInputType,
        controller: widget.controller,
        obscureText: widget.obscureText ? !_passwordVisible : false,
        enableSuggestions: !widget.obscureText,
        autocorrect: !widget.obscureText,
        style: (widget.textStyle ?? Styles.textFieldStyle)
            .copyWith(color: widget.textColor),
        focusNode: widget.focusNode,
        maxLines: widget.expands ? null : (widget.maxLine ?? 1),
        maxLength: widget.maxLength,
        onChanged: widget.isDatePicker
            ? (value) {
          _handleDateInput(value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        }
            : widget.onChanged,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          filled: widget.isFilled,
          fillColor: widget.isFilled
              ? widget.fillColor ?? Palette.white
              : null,
          label: widget.labelWidget,
          errorText: null,
          isDense: true,
          labelText:
          widget.maxLine == null ? widget.name ?? widget.label : widget.label,
          hintText: widget.hintText,
          counterText: widget.counterText ?? "",
          hintStyle: widget.hintTextStyle ?? Styles.hintTextStyle,
          labelStyle: widget.textStyle ?? Styles.labelTextStyle,
          border: widget.isBorderNeeded
              ? OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Palette.greyLight,
              width: 1,
            ),
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 6),
          )
              : InputBorder.none,
          enabledBorder: widget.isBorderNeeded
              ? OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.enabledBorderColor ??
                  widget.borderColor ??
                  Palette.greyLight,
              width: 1,
            ),
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 6),
          )
              : InputBorder.none,
          focusedBorder: widget.isBorderNeeded
              ? OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? Palette.kPrimary,
              width: 2,
            ),
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 6),
          )
              : InputBorder.none,
          floatingLabelBehavior:
          widget.floating ? FloatingLabelBehavior.always : null,
          prefixIcon: widget.prefixWidget,
          prefixText: widget.isPrefixTextNeeded
              ? "₹"
              : null,
          suffixIcon: _buildSuffixIcon(),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isDatePicker) {
      return IconButton(
        icon: Icon(
          Icons.calendar_month_sharp,
          color: Palette.borderGrey,
          size: 20,
        ),
        onPressed: () => _selectDate(context),
      );
    } else if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      );
    } else if (widget.suffixDropDown && widget.iconWithFunction != null) {
      return widget.iconWithFunction;
    } else if (widget.suffixDropDown) {
      return const Icon(
        Icons.arrow_drop_down_outlined,
        size: 25,
        color: Palette.black,
      );
    } else {
      return widget.suffixIcon;
    }
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.length > oldValue.text.length) {
      if (text.length == 2 || text.length == 5) {
        if (!text.endsWith('/')) {
          return TextEditingValue(
            text: '$text/',
            selection: TextSelection.collapsed(offset: text.length + 1),
          );
        }
      }
    }

    return newValue;
  }
}



