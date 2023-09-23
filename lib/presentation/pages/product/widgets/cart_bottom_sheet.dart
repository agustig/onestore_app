import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/buttons/custom_button.dart';
import 'package:flutter_store_fic7/presentation/pages/checkout/checkout_page.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';
import 'package:flutter_store_fic7/utils/price_extension.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.read<OrderBloc>();

    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (_, current) => current.currentItem != null,
      builder: (context, state) {
        final item = state.currentItem!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).highlightColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).hintColor,
                              spreadRadius: 1,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.clear,
                          size: Dimensions.iconSizeSmall,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: ColorResources.getImageBg(context),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: .5,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.20),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                image: item.product.imageUrl,
                                imageErrorBuilder: (c, o, s) =>
                                    Image.asset(Images.placeholder),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: Dimensions.paddingSizeSmall,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orange),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall,
                                    ),
                                    Text(
                                      double.parse('5').toStringAsFixed(1),
                                      style: titilliumSemiBold.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: Dimensions.paddingSizeDefault,
                                ),
                                Text(
                                  item.product.price.formatPrice(),
                                  style: titilliumRegular.copyWith(
                                    color: ColorResources.getPrimary(context),
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  const SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  Row(
                    children: [
                      const Text('Quantity', style: robotoBold),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () => (item.quantity <= 1)
                            ? null
                            : orderBloc
                                .add(OrderEvent.removeProduct(item.product)),
                        child: const Text('-'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('${item.quantity}', style: titilliumSemiBold),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () => orderBloc.add(
                          OrderEvent.addProduct(item.product),
                        ),
                        child: const Text('+'),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Total Price', style: robotoBold),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Text(
                        ((int.parse(item.product.price)) * item.quantity)
                            .toString()
                            .formatPrice(),
                        style: titilliumBold.copyWith(
                          color: ColorResources.getPrimary(context),
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            buttonText: 'Add to Cart',
                            onTap: () {
                              orderBloc.add(const OrderEvent.addItemToCart());
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(
                        child: CustomButton(
                          isBuy: true,
                          buttonText: 'Buy Now',
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutPage(),
                              )).whenComplete(() => Navigator.pop(context)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// class QuantityButton extends StatelessWidget {
//   final bool isIncrement;
//   final int? quantity;
//   final bool isCartWidget;
//   final int? stock;
//   final int? minimumOrderQuantity;
//   final bool digitalProduct;

//   const QuantityButton({
//     Key? key,
//     required this.isIncrement,
//     required this.quantity,
//     required this.stock,
//     this.isCartWidget = false,
//     required this.minimumOrderQuantity,
//     required this.digitalProduct,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         // if (!isIncrement && quantity! > 1) {
//         //   if (quantity! > minimumOrderQuantity!) {
//         //   } else {
//         //     Fluttertoast.showToast(
//         //         msg: 'minimum qty 1',
//         //         toastLength: Toast.LENGTH_SHORT,
//         //         gravity: ToastGravity.BOTTOM,
//         //         timeInSecForIosWeb: 1,
//         //         backgroundColor: Colors.red,
//         //         textColor: Colors.white,
//         //         fontSize: 16.0);
//         //   }
//         // } else if (isIncrement && quantity! < stock! || digitalProduct) {}
//       },
//       icon: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border:
//                 Border.all(width: 1, color: Theme.of(context).primaryColor)),
//         child: Icon(
//           isIncrement ? Icons.add : Icons.remove,
//           color: isIncrement
//               ? quantity! >= stock! && !digitalProduct
//                   ? ColorResources.getLowGreen(context)
//                   : ColorResources.getPrimary(context)
//               : quantity! > 1
//                   ? ColorResources.getPrimary(context)
//                   : ColorResources.getTextTitle(context),
//           size: isCartWidget ? 26 : 20,
//         ),
//       ),
//     );
//   }
// }
