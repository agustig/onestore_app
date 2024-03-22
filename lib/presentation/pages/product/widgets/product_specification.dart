import 'package:flutter/material.dart';
import 'package:onestore_app/presentation/pages/base_widgets/title_row.dart';
import 'package:onestore_app/utils/dimensions.dart';

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  const ProductSpecification({super.key, required this.productSpecification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleRow(
          title: 'Specification',
          isDetailsPage: true,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        productSpecification.isNotEmpty
            ? Expanded(child: Text(productSpecification))
            : const Center(child: Text('No specification')),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}
