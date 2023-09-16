import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:shimmer/shimmer.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          width: width,
          height: width * 0.4,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}
