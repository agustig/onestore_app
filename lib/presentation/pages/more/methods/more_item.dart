part of '../more_page.dart';

Widget moreItem(String title, {VoidCallback? onTap}) => GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
