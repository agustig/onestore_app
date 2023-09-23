import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/custom_app_bar.dart';
import 'package:flutter_store_fic7/presentation/pages/product/widgets/product_item_widget.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';

class CategoryProductsPage extends StatelessWidget {
  final Category category;
  const CategoryProductsPage({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    context
        .read<ProductBloc>()
        .add(ProductEvent.getProductsByCategory(category));

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(title: category.name),

          const SizedBox(height: Dimensions.paddingSizeSmall),

          // Products
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                loaded: (singleProduct, products, canLoadMore) {
                  return Expanded(
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall,
                      ),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItemWidget(product: products[index]);
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
