import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopera/core/constants/colors.dart';

import '../../core/widgets/button_primary.dart';
import '../../core/widgets/snackbar_global.dart';
import '../cart/persentation/cubit/cart_cubit.dart';
import '../home/domin/entities/product_entity.dart';
import '../home/persentation/components/category_selector.dart';
import '../home/persentation/components/dynamic_product_card.dart';
import '../home/persentation/components/tiled_title.dart';
import '../home/persentation/cubit/products_cubit.dart';
import 'search_delegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = 'search page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCategory = '';
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
        await cubit.getProductsByCategory(category: selectedCategory, pageNumber: nextPage);
        isLoading = false;
      }
    }
  }

  void retry() {
    nextPage = 1;
    cubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(cubit),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsStateLoaded) {
            if (state.hasMessage) {
              SnackBarGlobal.show(context, state.message!);
            }
            if (state.hasMoreProductsWithPagenation) {
              nextPage++;
            }
          }
        },
        builder: (context, state) {
          if (state is ProductsStateLoading || state is ProductsStateLoaded && state.loadingData) {
            return const Center(
              child: SpinKitWaveSpinner(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is ProductsStateLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                retry();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: buildSearchBody(state),
              ),
            );
          } else if (state is ProductsStateFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: 200,
                    child: PrimaryButton(
                      onPressed: () {
                        retry();
                      },
                      labelText: 'Retry',
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildSearchBody(ProductsStateLoaded state) {
    final filteredProducts = state.products;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(
          child: TiledTitle(
            title: 'Categories',
            tileText: 'See All',
            onTap: () {},
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
        SliverToBoxAdapter(
          child: CategorySelector(
            categories: state.categories,
            selectedValue: (value) {
              setState(() {
                cubit.getProductsByCategory(category: value, pageNumber: 0);
              });
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(
          child: TiledTitle(
            title: 'All products for you',
            tileText: 'See All',
            onTap: () {},
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverGrid.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            childAspectRatio: 0.67,
          ),
          itemBuilder: (context, index) {
            return buildProductItem(filteredProducts[index]);
          },
        ),
        if (!state.hasMoreProductsWithPagenation)
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('No more data to products'),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildProductItem(ProductEntity product) {
    final cartCubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return DynamicProductCard(
          isAddedToCart: cartCubit.continItem(product.id),
          toggleCart: () {
            if (!cartCubit.continItem(product.id)) {
              cartCubit.addItem(product.id);
            } else {
              cartCubit.deleteItem(product.id);
            }
          },
          toggleFavorite: () {},
          type: 'typeA',
          product: product,
        );
      },
    );
  }
}
