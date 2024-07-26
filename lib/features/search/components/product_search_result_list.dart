import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/constants/colors.dart';
import '../../home/persentation/components/dynamic_product_card.dart';
import '../../home/persentation/cubit/products_cubit.dart';

class ProductSearchResults extends StatefulWidget {
  final String query;

  const ProductSearchResults({
    super.key,
    required this.query,
  });

  @override
  State createState() => _ProductSearchResultsState();
}

class _ProductSearchResultsState extends State<ProductSearchResults> {
  late final ScrollController _scrollController;
  late ProductsCubit cubit;
  bool isLoading = false;
  int nextPage = 1;

  @override
  void initState() {
    cubit = context.read<ProductsCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() async {
    if (!mounted) return;
    var currentPosition = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition >= (0.7 * maxScrollLength)) {
      if (!isLoading) {
        isLoading = true;
        await cubit.search(query: widget.query, pageNumber: nextPage);
        isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(listener: (context, state) {
      if (state is ProductsStateLoaded && state.hasMoreProductsSearchWithPagenation) {
        nextPage++;
      }
    }, builder: (context, state) {
      if (state is ProductsStateLoaded) {
        if (state.loadingData) {
          return const Center(
            child: SpinKitWaveSpinner(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state.productsBySearch.isEmpty) {
          return const Center(child: Text('No Results Found'));
        }
        final productSearch = state.productsBySearch;
        return ListView.builder(
          controller: _scrollController,
          itemCount: productSearch.length,
          itemBuilder: (context, index) {
            return DynamicProductCard(
              product: productSearch[index],
              type: 'typeA',
              toggleFavorite: () {},
              toggleCart: () {},
            );
          },
        );
      } else if (state is ProductsStateFailure) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  cubit.search(query: widget.query, pageNumber: 0);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
