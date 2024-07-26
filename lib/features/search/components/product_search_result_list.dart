import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopera/features/home/persentation/components/products_sliver_grid_view.dart';
import 'package:shopera/features/search/cubit/search_cubit.dart';

import '../../../core/constants/colors.dart';

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
  late SearchCubit cubit;
  bool isLoading = false;
  int nextPage = 1;

  @override
  void initState() {
    cubit = context.read<SearchCubit>();
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
    return BlocConsumer<SearchCubit, SearchState>(listener: (context, state) {
      if (state is SearchLoaded && state.hasMoreProducts) {
        nextPage++;
      }
    }, builder: (context, state) {
      if (state is SearchLoaded) {
        if (state.loading) {
          return const Center(
            child: SpinKitWaveSpinner(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state.products.isEmpty) {
          return const Center(child: Text('No Results Found'));
        }
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: CustomScrollView(slivers: [ProductSliverGridView(products: state.products)]),
        );
      } else if (state is SearchFailure) {
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
