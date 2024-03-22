import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/payment/payment_failed_page.dart';
import 'package:flutter_store_fic7/presentation/pages/payment/payment_success_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String url;

  const PaymentPage({
    super.key,
    required this.url,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController? controller;

  @override
  void initState() {
    final orderBloc = context.read<OrderBloc>();
    final processingOrder = orderBloc.state.processing!;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url.contains('status_code=202&transaction_status=deny')) {
              orderBloc.add(OrderEvent.addCheckoutStatus(
                order: processingOrder,
                isPlaced: false,
              ));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return const PaymentFailedPage();
              }), (_) {
                return false;
              });
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              orderBloc.add(OrderEvent.addCheckoutStatus(
                order: processingOrder,
                isPlaced: true,
              ));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return const PaymentSuccessPage();
              }), (_) {
                return false;
              });
            }
          },
          onPageFinished: (String url) {
            if (url.contains('status_code=202&transaction_status=deny')) {
              orderBloc.add(OrderEvent.addCheckoutStatus(
                order: processingOrder,
                isPlaced: false,
              ));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return const PaymentFailedPage();
              }), (_) {
                return false;
              });
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              orderBloc.add(OrderEvent.addCheckoutStatus(
                order: processingOrder,
                isPlaced: true,
              ));
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return const PaymentSuccessPage();
              }), (_) {
                return false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller!)),
    );
  }
}
