import '../cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import '../components/top_swiper.dart';
import '../components/tiled_title.dart';
import '../components/category_selector.dart';
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
  late final ScrollController _scrollController;
  late HomeCubit cubit;
  bool isLoading = false;
  int nextPage = 1;
  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    var cureentPosition = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (cureentPosition >= (maxScrollLength)) {
      if (!isLoading) {
        isLoading = true;
        await cubit.getProducts(pageNumber: nextPage);
        isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeStateLoaded) {
              if (state.products.isNotEmpty) {
                cubit.products.addAll(state.products);
                nextPage++;
              }
            }
          },
          builder: (context, state) {
            if (state is HomeStateLoaded) {
              if (state.loadingData) {
                return const Center(
                  child: SpinKitWaveSpinner(
                    color: AppColors.primaryColor,
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    retry();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: buildHomeBody(state),
                  ),
                );
              }
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
        ));
  }

  void retry() {
    cubit.products.clear();
    nextPage = 1;
    cubit.loadData();
  }

  Widget buildHomeBody(HomeStateLoaded state) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
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
          itemCount: cubit.products.length + 1,
          itemBuilder: (context, index) {
            if (index < cubit.products.length) {
              return DynamicProductCard(
                type: 'typeA',
                product: cubit.products[index],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: state.products.isEmpty
                      ? const Text('No more data to products')
                      : const SpinKitWaveSpinner(
                          size: 40,
                          color: AppColors.primaryColor,
                        ),
                ),
              );
            }
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 7)),
      ],
    );
  }
}
