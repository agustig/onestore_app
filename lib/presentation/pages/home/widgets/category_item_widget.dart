import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/presentation/bloc/product/product_bloc.dart';
import 'package:onestore_app/presentation/pages/product/category_products_page.dart';
import 'package:onestore_app/utils/color_resource.dart';
import 'package:onestore_app/utils/custom_theme.dart';
import 'package:onestore_app/utils/dimensions.dart';
import 'package:onestore_app/utils/images.dart';

class CategoryItemWidget extends StatelessWidget {
  final Category category;
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(category: category),
          ),
        ).whenComplete(() => context.read<ProductBloc>().add(
              const ProductEvent.getProducts(),
            ));
      },
      child: Column(children: [
        Container(
          height: MediaQuery.sizeOf(context).width / 5,
          width: MediaQuery.sizeOf(context).width / 5,
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.2)),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).highlightColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: Images.placeholder,
              image: 'https://picsum.photos/20${category.id}',
              imageErrorBuilder: (c, o, s) => Image.asset(
                Images.placeholder,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Center(
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: ColorResources.getTextTitle(context)),
          ),
        ),
      ]),
    );
  }
}
