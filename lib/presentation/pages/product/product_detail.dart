import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/presentation/bloc/product/product_bloc.dart';
import 'package:onestore_app/presentation/pages/product/widgets/bottom_cart_view.dart';
import 'package:onestore_app/presentation/pages/product/widgets/product_image_view.dart';
import 'package:onestore_app/presentation/pages/product/widgets/product_specification.dart';
import 'package:onestore_app/presentation/pages/product/widgets/product_title_view.dart';
import 'package:onestore_app/utils/custom_theme.dart';
import 'package:onestore_app/utils/dimensions.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productState = context.watch<ProductBloc>().state;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).cardColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Text(
              'Product Detail',
              style: robotoRegular.copyWith(
                fontSize: 20,
                color: Theme.of(context).cardColor,
              ),
            ),
          ]),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (_, current) =>
              current.whenOrNull(
                loaded: (singleProduct, _, canLoadMore) =>
                    singleProduct != null,
              ) ??
              false,
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Placeholder(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (singleProduct, products, canLoadMore) {
                final product = singleProduct!;
                return RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProductImageView(
                          imageUrl: product.imageUrl,
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                          padding: const EdgeInsets.only(
                            top: Dimensions.fontSizeDefault,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                Dimensions.paddingSizeExtraLarge,
                              ),
                              topRight: Radius.circular(
                                Dimensions.paddingSizeExtraLarge,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              ProductTitleView(
                                product: product,
                              ),
                              Container(
                                height: 250,
                                margin: const EdgeInsets.only(
                                  top: Dimensions.paddingSizeSmall,
                                ),
                                padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall,
                                ),
                                child: ProductSpecification(
                                  productSpecification: product.description,
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: productState.whenOrNull(
          loaded: (singleProduct, _, canLoadMore) => BottomCartView(
            product: singleProduct!,
          ),
        ),
      ),
    );
  }
}
