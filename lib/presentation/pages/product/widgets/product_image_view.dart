import 'package:flutter/material.dart';
import 'package:onestore_app/presentation/pages/product/widgets/favorite_button.dart';
import 'package:onestore_app/utils/color_resource.dart';
import 'package:onestore_app/utils/dimensions.dart';
import 'package:onestore_app/utils/images.dart';

class ProductImageView extends StatelessWidget {
  final String imageUrl;
  const ProductImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ],
              gradient: const LinearGradient(
                colors: [ColorResources.white, ColorResources.imageBg],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).width,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: Images.placeholder,
                        height: MediaQuery.sizeOf(context).width,
                        width: MediaQuery.sizeOf(context).width,
                        image: imageUrl,
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder,
                          height: MediaQuery.sizeOf(context).width,
                          width: MediaQuery.sizeOf(context).width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (index) {},
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _indicators(context),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(
                        right: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSizeDefault,
                      ),
                      child: Text('1'),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    FavoriteButton(
                      backgroundColor: ColorResources.getImageBg(context),
                      favColor: Colors.redAccent,
                      isSelected: true,
                      productId: 1,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share,
                            color: Theme.of(context).cardColor,
                            size: Dimensions.iconSizeSmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ]),
          ),
        ),
      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < 3; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor:
            index == 1 ? Theme.of(context).primaryColor : ColorResources.white,
        borderColor: ColorResources.white,
        size: 10,
      ));
    }
    return indicators;
  }
}
