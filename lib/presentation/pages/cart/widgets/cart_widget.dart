import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/product/product_detail.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';
import 'package:flutter_store_fic7/utils/price_extension.dart';

class CartWidget extends StatelessWidget {
  final OrderItem orderItem;

  const CartWidget({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<ProductBloc>()
            .add(ProductEvent.getProduct(orderItem.product.id));
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (context, anim1, anim2) => const ProductDetail(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.paddingSizeExtraSmall,
                ),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(.20),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Dimensions.paddingSizeExtraSmall,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  height: 60,
                  width: 60,
                  image: orderItem.product.imageUrl,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            orderItem.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titilliumBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.getReviewRattingColor(
                                context,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeSmall,
                        ),
                        InkWell(
                          onTap: () => context
                              .read<OrderBloc>()
                              .add(OrderEvent.removeFromCart(orderItem)),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              Images.delete,
                              scale: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          orderItem.product.price.formatPrice(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: titilliumRegular.copyWith(
                            color: ColorResources.getPrimary(context),
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(' x ${orderItem.quantity}'),
                      ],
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
