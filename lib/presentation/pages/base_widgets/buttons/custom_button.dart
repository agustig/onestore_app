import 'package:flutter/material.dart';
import 'package:onestore_app/utils/custom_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final double? radius;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.isBuy = false,
    this.isBorder = false,
    this.backgroundColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(
        height: 45.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor ??
                (isBuy
                    ? const Color(0xffFE961C)
                    : Theme.of(context).primaryColor),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 7.0,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Text(
          buttonText,
          style: titilliumSemiBold.copyWith(
            fontSize: 16,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
    );
  }
}
