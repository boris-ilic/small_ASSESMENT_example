
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka_assessment/components/custom_outline_input_border.dart';
import 'package:maka_assessment/constants/font_sizes.dart';
import 'package:maka_assessment/helpers/validators.dart';
import 'package:maka_assessment/style/color_palette.dart';
import 'package:maka_assessment/style/font_styles.dart';

typedef OnFocusChanged = void Function(bool hasFocus);

class PrimaryInput extends StatefulWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final String? obscuringCharacter;
  final Color? textColor;
  final bool isPassword;
  final bool isEnabled;
  final bool isRequired;
  final bool? isTextArea;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? lengthLimit;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization? textCapitalization;
  final BorderSide? borderSide;
  final BorderSide? errorBorderSide;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final bool isNewUserField;
  final bool isWithoutSpaces;
  final bool isOnlyNumbers;
  final bool readOnly;
  final bool isValidationEnabled;
  final String? errorText;
  final OnFocusChanged? onFocusChanged;
  final ScrollController? scrollController;

  const PrimaryInput({
    Key? key,
    this.fieldKey,
    this.initialValue,
    this.controller,
    this.validator,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    this.isEnabled = true,
    this.isRequired = false,
    this.isTextArea = false,
    this.prefixIcon,
    this.suffixIcon,
    this.lengthLimit,
    this.focusNode,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.autovalidateMode,
    this.textCapitalization,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.isNewUserField = false,
    this.isWithoutSpaces = false,
    this.isOnlyNumbers = false,
    this.isValidationEnabled = false,
    this.readOnly = false,
    this.borderSide,
    this.errorBorderSide,
    this.contentPadding,
    this.obscuringCharacter,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.errorText,
    this.onFocusChanged,
    this.scrollController,
  })  : assert(
            isValidationEnabled && controller != null && fieldKey != null || !isValidationEnabled),
        super(key: key);

  @override
  State<PrimaryInput> createState() => _PrimaryInputState();
}

class _PrimaryInputState extends State<PrimaryInput> {
  final _inputFocus = FocusNode();
  bool _validationEnabled = false;
  late String text;

  @override
  void initState() {
    super.initState();

    text = widget.controller?.text.trim() ?? '';

    if (widget.controller != null) {
      if (widget.isValidationEnabled) {
        if (widget.focusNode == null) {
          _inputFocus.addListener(() {
            widget.onFocusChanged?.call(_inputFocus.hasFocus);
            if (!_inputFocus.hasFocus && widget.controller!.text.isNotEmpty) {
              _validationEnabled = true;
              widget.fieldKey?.currentState?.validate();
            }
          });
        } else {
          widget.focusNode!.addListener(() {
            widget.onFocusChanged?.call(widget.focusNode!.hasFocus);
            if (!widget.focusNode!.hasFocus && widget.controller!.text.isNotEmpty) {
              _validationEnabled = true;
              widget.fieldKey?.currentState?.validate();
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelTitleText = widget.labelText != null ? '${widget.labelText} ' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        !widget.isNewUserField
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Text(labelTitleText, style: FontStyles.fontRegular16),
                    Text(
                      '*',
                      style: FontStyles.fontRegular16.apply(color: ColorPalette.red30),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        widget.isNewUserField ? const SizedBox(height: 0) : const SizedBox(height: 5),
        TextFormField(
          key: widget.fieldKey,
          readOnly: widget.readOnly,
          scrollController: widget.scrollController,
          focusNode: widget.focusNode ?? (widget.isValidationEnabled ? _inputFocus : null),
          obscureText: widget.isPassword,
          obscuringCharacter: widget.obscuringCharacter ?? '•',
          initialValue: widget.initialValue,
          enabled: widget.isEnabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textAlign: widget.textAlign,
          validator: widget.validator,
          controller: widget.controller,
          scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          keyboardType: widget.keyboardType ??
              (widget.isOnlyNumbers ? TextInputType.number : TextInputType.text),
          textInputAction: widget.textInputAction,
          style: FontStyles.fontRegular16.copyWith(
            color: widget.isEnabled
                ? widget.textColor ?? ColorPalette.black
                : ColorPalette.gray50.withOpacity(0.5),
            height: 1.2,
            overflow: TextOverflow.ellipsis,
          ),
          inputFormatters: widget.inputFormatters ??
              (widget.lengthLimit != null
                  ? [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z 0-9`~!@#$%?"^&*()_+\\\-={}\[\]/.,<>;]')),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      LengthLimitingTextInputFormatter(widget.lengthLimit),
                    ]
                  : widget.isOnlyNumbers
                      ? [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'\d*\.?\d+'),
                          ),
                        ]
                      : [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'[a-z A-Z0-9`~!@#$%?"^&*()_+\\\-={}\[\]/.,<>;]',
                            ),
                          ),
                          if (widget.isWithoutSpaces)
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ]),
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (_validationEnabled) widget.fieldKey?.currentState?.validate();
          },
          onEditingComplete: widget.onEditingComplete,
          autovalidateMode: widget.autovalidateMode,
          smartDashesType: SmartDashesType.disabled,
          decoration: InputDecoration(
            filled: !widget.isEnabled ? true : false,
            fillColor: !widget.isEnabled ? ColorPalette.gray10 : null,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            labelText: !widget.isRequired
                ? widget.isNewUserField
                    ? widget.labelText
                    : widget.hintText
                : null,
            label: widget.isRequired
                ? RichText(
                    text: TextSpan(
                      text: widget.isNewUserField ? widget.labelText : widget.hintText,
                      style: TextStyle(
                        color: ColorPalette.gray70,
                        fontSize: FontSizes.fontSize16,
                      ),
                      children: <TextSpan>[
                        widget.isRequired
                            ? const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: ColorPalette.red50,
                                ),
                              )
                            : const TextSpan(
                                text: '',
                                style: TextStyle(
                                  color: ColorPalette.red50,
                                ),
                              ),
                      ],
                    ),
                  )
                : null,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.only(
                  top: 16,
                  bottom: 12,
                  left: 12,
                  right: 12,
                ),
            floatingLabelBehavior:
                widget.isNewUserField ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
            labelStyle: widget.isNewUserField
                ? FontStyles.fontRegular16.copyWith(
                    color: ColorPalette.gray70,
                    backgroundColor: Colors.transparent,
                    height: 0.8,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            hintStyle: FontStyles.fontRegular16.copyWith(
              color: widget.isTextArea! ? ColorPalette.gray40 : ColorPalette.gray70,
              overflow: TextOverflow.ellipsis,
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              color: ColorPalette.red50,
              height: Validators.isStringNotEmpty(text) ? 0 : 0,
              fontSize: 14.0,
              overflow: TextOverflow.ellipsis,
            ),
            errorMaxLines: 2,
            border: widget.isNewUserField
                ? CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: widget.borderSide ?? const BorderSide(color: ColorPalette.gray30),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: const BorderSide(color: ColorPalette.gray30),
                  ),
            focusedBorder: widget.isNewUserField
                ? CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: widget.borderSide ?? const BorderSide(color: ColorPalette.gray30),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: widget.borderSide ?? const BorderSide(color: ColorPalette.gray30),
                  ),
            enabledBorder: widget.isNewUserField
                ? CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: widget.borderSide ?? const BorderSide(color: ColorPalette.gray30),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: widget.borderSide ?? const BorderSide(color: ColorPalette.gray30),
                  ),
            errorBorder: widget.isNewUserField
                ? CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide:
                        widget.errorBorderSide ?? const BorderSide(color: ColorPalette.red50),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide:
                        widget.errorBorderSide ?? const BorderSide(color: ColorPalette.red50),
                  ),
            focusedErrorBorder: widget.isNewUserField
                ? CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide:
                        widget.errorBorderSide ?? const BorderSide(color: ColorPalette.red50),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide:
                        widget.errorBorderSide ?? const BorderSide(color: ColorPalette.red50),
                  ),
          ),
        ),
      ],
    );
  }
}
