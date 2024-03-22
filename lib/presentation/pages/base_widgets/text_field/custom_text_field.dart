import 'package:flutter/material.dart';
import 'package:onestore_app/utils/custom_theme.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    const regExpPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    return RegExp(regExpPattern).hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;
  final TextAlign? textAlign;
  final bool isEnable;
  final String? errorText;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.textInputType,
    this.maxLine,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.fillColor,
    this.capitalization = TextCapitalization.none,
    this.isBorder = false,
    this.textAlign,
    this.isEnable = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: isBorder
            ? Border.all(
                width: 8.0,
                color: Theme.of(context).hintColor,
              )
            : null,
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        textAlign: textAlign != null
            ? textAlign!
            : isBorder
                ? TextAlign.center
                : TextAlign.start,
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        enabled: isEnable,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        decoration: InputDecoration(
          hintText: hintText,
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 15,
          ),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          hintStyle: titilliumRegular.copyWith(
            color: Theme.of(context).hintColor,
          ),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none,
          errorText: errorText,
        ),
      ),
    );
  }
}
