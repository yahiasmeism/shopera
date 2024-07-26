import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopera/core/constants/colors.dart';
import 'package:shopera/features/home/persentation/components/products_sliver_grid_view.dart';

import '../../core/widgets/button_primary.dart';
import '../../core/widgets/snackbar_global.dart';
import '../home/persentation/components/category_selector.dart';
import '../home/persentation/components/tiled_title.dart';
import '../home/persentation/cubit/products_cubit.dart';
import 'components/search_delegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = 'search page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final ScrollController _scrollController;
  late ProductsCubit cubit;
  bool isLoading = false;
  int pageNumber = 0;

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
        await cubit.getProductsByCategory(pageNumber: pageNumber);
        isLoading = false;
      }
    }
  }

  void retry() {
    pageNumber = 0;
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
              pageNumber++;
            }
          }
        },
        builder: (context, state) {
          if (state is ProductsStateLoaded) {
            if (state.loadingData) {
              return const Center(
                child: SpinKitWaveSpinner(
                  color: AppColors.primaryColor,
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                retry();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: buildBody(state),
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

  Widget buildBody(ProductsStateLoaded state) {
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
            initialCategory: state.selectedCategory,
            categories: state.categories,
            selectedValue: (value) {
              cubit.changeCategory(value);
              pageNumber = 0;
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
        ProductSliverGridView(products: state.products)
      ],
    );
  }
}
