import 'package:shopera/core/constants/app_constants.dart';
import 'package:shopera/core/utils/nav_bar_cubit.dart';
import 'package:shopera/core/widgets/rounded_category.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';
import 'package:shopera/features/home/persentation/components/category_selector.dart';
import 'package:shopera/features/search/search_page.dart';

import '../cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import '../components/top_swiper.dart';
import '../components/tiled_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../components/dynamic_product_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/widgets/button_primary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = 'home page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductsCubit cubit;
  @override
  void initState() {
    cubit = context.read<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ProductsStateLoaded && state.hasMessage) {
              SnackBarGlobal.show(context, state.message!);
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
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    retry(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: buildHomeBody(state),
                  ),
                );
              }
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
                          retry(context);
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
        ));
  }

  Widget buildHomeBody(ProductsStateLoaded state) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: HomePageTopSwiper(size: size)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(
          child: TiledTitle(
            title: 'Categories',
            tileText: 'See All',
            onTap: () {},
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
        //Categories Grid View
        SliverToBoxAdapter(
            child: CategorySelector(
          initialCategory: state.selectedCategory,
          categories: state.categories,
          selectedValue: (value) {
            Navigator.pushNamed(context, SearchPage.routeName);
            cubit.changeCategory(value);
          },
        )),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(
          child: TiledTitle(
            title: 'Popular products for you',
            tileText: 'See All',
            onTap: () {
              context.read<NavigationBarCubit>().navigateTo(NavigationBarState.search);
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverGrid.builder(
          itemCount: state.popularProduct.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            return buildProductItem(state.popularProduct[index]);
          },
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
          type: 'typeB',
          product: product,
        );
      },
    );
  }

  void retry(BuildContext context) {
    context.read<ProductsCubit>().loadData();
  }
}
