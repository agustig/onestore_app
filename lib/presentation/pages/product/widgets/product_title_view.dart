import 'package:flutter/material.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/utils/color_resource.dart';
import 'package:onestore_app/utils/custom_theme.dart';
import 'package:onestore_app/utils/dimensions.dart';
import 'package:onestore_app/utils/price_extension.dart';

class ProductTitleView extends StatelessWidget {
  final Product product;
  const ProductTitleView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: titleRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Column(
                  children: [
                    Text(
                      product.price.formatPrice(),
                      style: titilliumBold.copyWith(
                        color: ColorResources.getPrimary(context),
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],
        ));
  }
}
