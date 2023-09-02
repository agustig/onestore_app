import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;

  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _obscureText = true;

  // Toggle to show password status
  void _toggle() {
    setState(() {
      _obscureText != _obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 7.0,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          controller: widget.controller,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (value) {
            setState(() {
              widget.textInputAction == TextInputAction.done
                  ? FocusScope.of(context).consumeKeyboardToken()
                  : FocusScope.of(context).requestFocus(widget.nextNode);
            });
          },
          validator: (value) => null,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _toggle,
            ),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12.0,
            ),
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).highlightColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            hintStyle: titilliumRegular.copyWith(
              color: Theme.of(context).hintColor,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
