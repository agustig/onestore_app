import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/presentation/bloc/order/order_bloc.dart';
import 'package:onestore_app/presentation/pages/cart/cart_page.dart';
import 'package:onestore_app/presentation/pages/product/widgets/cart_bottom_sheet.dart';
import 'package:onestore_app/utils/color_resource.dart';
import 'package:onestore_app/utils/custom_theme.dart';
import 'package:onestore_app/utils/dimensions.dart';
import 'package:onestore_app/utils/images.dart';

class BottomCartView extends StatelessWidget {
  final Product product;
  const BottomCartView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.watch<OrderBloc>();
    final itemsInCart =
        orderBloc.state.cart.where((item) => item.product == product).toList();
    final productCountInCart =
        (itemsInCart.isNotEmpty) ? itemsInCart[0].quantity : 0;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor,
            blurRadius: 0.5,
            spreadRadius: 0.1,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Stack(children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    )),
                    child: Image.asset(
                      Images.cartArrowDownImage,
                      color: ColorResources.getPrimary(context),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: Container(
                      height: 17,
                      width: 17,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.getPrimary(context),
                      ),
                      child: Text(
                        '$productCountInCart',
                        style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ),
                  )
                ]),
              )),
          Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                orderBloc.add(OrderEvent.addProduct(product));
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0),
                  builder: (context) => const CartBottomSheet(),
                ).whenComplete(
                  () => orderBloc.add(const OrderEvent.resetItem()),
                );
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.getPrimary(context),
                ),
                child: Text(
                  'Add',
                  style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
