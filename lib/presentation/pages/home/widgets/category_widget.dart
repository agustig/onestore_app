import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/presentation/bloc/category/category_bloc.dart';
import 'package:onestore_app/presentation/pages/home/widgets/category_item_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (message) {
            return Center(
              child: Text(message),
            );
          },
          loaded: (singleCategory, categories, canLoadMore) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 5,
                childAspectRatio: (1 / 1.3),
              ),
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const CategoryProductsPage(
                    //       isBrand: false,
                    //       id: '1',
                    //     ),
                    //   ),
                    // );
                  },
                  child: CategoryItemWidget(
                    category: categories[index],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
