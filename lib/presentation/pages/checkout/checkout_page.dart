import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_status/auth_status_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/amount_widget.dart';
import 'package:flutter_store_fic7/presentation/pages/payment/payment_page.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';
import 'package:flutter_store_fic7/utils/price_extension.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final deliveryAddress = TextEditingController();

  @override
  void dispose() {
    deliveryAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.watch<OrderBloc>();
    final orderState = orderBloc.state;
    final items = (orderState.currentItem != null)
        ? [orderState.currentItem!]
        : orderState.cart;
    final subTotalPriceOrder =
        items.map((item) => int.parse(item.product.price) * item.quantity);
    const shippingCost = 0;
    final subPrice = subTotalPriceOrder.isEmpty
        ? 0
        : subTotalPriceOrder.reduce((a, b) => a + b);
    final totalPrice = subPrice + shippingCost;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
            ),
            child: Text(
              'Shipping Address',
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: TextField(
              controller: deliveryAddress,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
            ),
            child: Text(
              'Order Detail',
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeLarge,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: .5,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraExtraSmall,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraExtraSmall,
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          image: item.product.imageUrl,
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.marginSizeDefault),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.product.name,
                                  style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: ColorResources.getPrimary(context),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                (int.parse(item.product.price) * item.quantity)
                                    .toString()
                                    .formatPrice(),
                                style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.marginSizeExtraSmall,
                          ),
                          Row(children: [
                            Text(
                              'Qty -  ${item.quantity}',
                              style: titilliumRegular,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Container(
            height: 40,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.055),
            ),
            child: Center(
                child: Text(
              'Order Summary',
              style: titilliumSemiBold.copyWith(
                fontSize: Dimensions.fontSizeLarge,
              ),
            )),
          ),
          // Total bill
          Container(
            margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            color: Theme.of(context).highlightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AmountWidget(
                  title: 'Sub Total :',
                  amount: '$subPrice'.formatPrice(),
                ),
                AmountWidget(
                  title: 'Shipping Cost: ',
                  amount:
                      (shippingCost == 0) ? 'free' : shippingCost.toString(),
                ),
                Divider(height: 5, color: Theme.of(context).hintColor),
                AmountWidget(
                  title: 'Total :',
                  amount: '$totalPrice'.formatPrice(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.status == OrderProcessingStatus.loading) {
            AlertDialog alert = AlertDialog(
              content: Row(
                children: [
                  const CircularProgressIndicator(),
                  Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: const Text("Placing order..."),
                  ),
                ],
              ),
            );
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          } else if (state.status == OrderProcessingStatus.error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ));
          } else if (state.status == OrderProcessingStatus.success) {
            final processingOrder = state.processing!;
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  url: processingOrder.paymentUrl,
                ),
              ),
            );
          }
        },
        child: InkWell(
          onTap: () {
            final authStatusState = context.read<AuthStatusBloc>().state;
            authStatusState.maybeWhen(
              orElse: () =>
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You need login first before checkout'),
                backgroundColor: Colors.red,
              )),
              authenticated: (token) {
                if (deliveryAddress.text.isNotEmpty) {
                  if (orderState.currentItem != null) {
                    orderBloc.add(
                      OrderEvent.buySingle(
                        deliveryAddress: deliveryAddress.text,
                        authToken: token,
                      ),
                    );
                  } else {
                    orderBloc.add(
                      OrderEvent.checkoutCart(
                        deliveryAddress: deliveryAddress.text,
                        authToken: token,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please input delivery address!'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            );
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeDefault,
            ),
            decoration: BoxDecoration(
              color: ColorResources.getPrimary(context),
            ),
            child: Center(
                child: Builder(
              builder: (context) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 2.9,
                ),
                child: Text('Proceed',
                    style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Theme.of(context).cardColor,
                    )),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

// class PaymentButton extends StatelessWidget {
//   final String image;
//   final Function? onTap;
//   const PaymentButton({Key? key, required this.image, this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap as void Function()?,
//       child: Container(
//         height: 45,
//         margin: const EdgeInsets.symmetric(
//           horizontal: Dimensions.paddingSizeExtraSmall,
//         ),
//         padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(width: 2, color: ColorResources.getGrey(context)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Image.asset(image),
//       ),
//     );
//   }
// }

// class PaymentMethod {
//   String name;
//   String image;
//   PaymentMethod(this.name, this.image);
// }
