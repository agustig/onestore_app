import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/custom_app_bar.dart';
import 'package:flutter_store_fic7/presentation/pages/cart/widgets/cart_widget.dart';
import 'package:flutter_store_fic7/presentation/pages/checkout/checkout_page.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/price_extension.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.watch<OrderBloc>();
    final orderState = orderBloc.state;
    final subTotalPriceOrder = orderState.cart
        .map((item) => int.parse(item.product.price) * item.quantity);
    final totalPrice = subTotalPriceOrder.isEmpty
        ? 0
        : subTotalPriceOrder.reduce((a, b) => a + b);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Cart'),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: orderState.cart.isNotEmpty
                        ? ListView.builder(
                            itemCount: orderState.cart.length,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeSmall,
                                ),
                                child: CartWidget(
                                  orderItem: orderState.cart[index],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Cart is empty'),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
          vertical: Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'Total Price ',
                      style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                    Text(
                      totalPrice.toString().formatPrice(),
                      style: titilliumSemiBold.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => InkWell(
                onTap: () {
                  if (orderState.cart.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Cart is empty, try to add product into cart!'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 3.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.paddingSizeSmall,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall,
                        vertical: Dimensions.fontSizeSmall,
                      ),
                      child: Text(
                        'Checkout',
                        style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
