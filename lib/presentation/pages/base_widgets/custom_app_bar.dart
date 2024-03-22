import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool isBackButtonExist;
  final IconData? icon;
  final Function? onActionPressed;
  final Function? onBackPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.isBackButtonExist = true,
      this.icon,
      this.onActionPressed,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbarBackground,
          fit: BoxFit.fill,
          height: 50 + MediaQuery.of(context).padding.top,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          isBackButtonExist
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 20, color: Colors.black),
                  onPressed: () => onBackPressed != null
                      ? onBackPressed!()
                      : Navigator.of(context).pop(),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: Text(
              title ?? 'Electronic',
              style: titilliumRegular.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          icon != null
              ? IconButton(
                  icon: Icon(icon,
                      size: Dimensions.iconSizeLarge, color: Colors.white),
                  onPressed: onActionPressed as void Function()?,
                )
              : const SizedBox.shrink(),
        ]),
      ),
    ]);
  }
}
