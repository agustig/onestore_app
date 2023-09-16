import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_store_fic7/presentation/pages/base_widgets/title_row.dart';
import 'package:flutter_store_fic7/presentation/pages/home/widgets/banner_widget.dart';
import 'package:flutter_store_fic7/presentation/pages/home/widgets/category_widget.dart';
import 'package:flutter_store_fic7/presentation/pages/home/widgets/product_item_widget.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Scaffold(
      backgroundColor: ColorResources.homeBg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logoWithNameImage, height: 35),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {
                        // TODO: add function for the card
                      },
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            Images.cartArrowDownImage,
                            height: Dimensions.iconSizeDefault,
                            width: Dimensions.iconSizeDefault,
                            color: ColorResources.getPrimary(context),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: ColorResources.red,
                              child: Text(
                                '10',
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.white,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: SliverDelegate(
                  child: InkWell(
                    onTap: () {
                      // TODO: add inkwell onTap function
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.homePagePadding,
                        vertical: Dimensions.paddingSizeSmall,
                      ),
                      color: ColorResources.homeBg,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: Dimensions.homePagePadding,
                          right: Dimensions.paddingSizeExtraSmall,
                          top: Dimensions.paddingSizeExtraSmall,
                          bottom: Dimensions.paddingSizeExtraSmall,
                        ),
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeExtraSmall,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search',
                              style: robotoRegular.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    Dimensions.paddingSizeExtraSmall,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.search,
                                color: Theme.of(context).cardColor,
                                size: Dimensions.iconSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.homePagePadding,
                      Dimensions.paddingSizeSmall,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      const BannerWidget(),
                      const SizedBox(height: Dimensions.homePagePadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(
                          title: 'Categories',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: Dimensions.homePagePadding),
                        child: CategoryWidget(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Expanded(child: Text('Products', style: titleHeader)),
                        ]),
                      ),
                      const SizedBox(height: Dimensions.homePagePadding),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.5 / 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ),
                    error: (message) => SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.5 / 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Center(
                              child: Text(message),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ),
                    loaded: (singleProduct, products, canLoadMore) =>
                        SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.5 / 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ProductItemWidget(
                              product: products[index],
                            );
                          },
                          childCount: products.length,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      )),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
