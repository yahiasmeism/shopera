import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/services/service_locator.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shopera/features/cart/persentation/components/cart_button.dart';
import 'package:shopera/features/home/persentation/components/dynamic_product_card.dart';
import 'package:shopera/features/home/persentation/cubit/home_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../components/category_selector.dart';
import '../components/tiled_title.dart';
import '../components/top_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'home';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: const [CartButtonWidget()],
        ),
        body: BlocProvider(
          create: (context) => AppDep.sl<HomeCubit>()..init(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeStateLoaded && state.message != null) {
                SnackBarGlobal.show(context, state.message!);
              }
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              if (state is HomeStateLoaded) {
                if (state.categoriesLoading && state.productsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomePageTopSwiper(
                          size: size,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 28)),
                      SliverToBoxAdapter(
                        child: TiledTitle(
                          title: 'Categories',
                          tileText: 'See All',
                          onTap: () {},
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 14)),
                      SliverToBoxAdapter(child: CategorySelector(categories: state.categoris)),
                      const SliverToBoxAdapter(child: SizedBox(height: 28)),
                      SliverToBoxAdapter(
                        child: TiledTitle(
                          title: 'Popular products for you',
                          tileText: 'See All',
                          onTap: () {},
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 28)),
                      SliverToBoxAdapter(
                        child: TiledTitle(
                          title: 'Latest Products',
                          tileText: 'See All',
                          onTap: () {},
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 14)),
                      SliverList.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return DynamicProductCard(
                            type: 'typeA',
                            product: state.products[index],
                          );
                        },
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 7)),
                    ],
                  ),
                );
              } else if (state is HomeStateFailure) {
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
                            cubit.reTryLoad();
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
        ));
  }
}
