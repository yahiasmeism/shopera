import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';
import 'package:shopera/features/home/persentation/components/category_selector.dart';
import 'package:shopera/features/home/persentation/components/dynamic_product_card.dart';
import 'package:shopera/features/home/persentation/components/search_textfield.dart';
import 'package:shopera/features/home/persentation/components/tiled_title.dart';
import 'package:shopera/features/home/persentation/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/widgets/button_primary.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = 'search page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   String selectedCategory ='';
  late final ScrollController _scrollController;
  late HomeCubit cubit;
  bool isLoading = false;
  int nextPage = 1;

   final _searchTextController = TextEditingController();
  String _searchQuery = '';

  @override
  @override  
void initState() {  
  cubit = context.read<HomeCubit>();  
  _scrollController = ScrollController();  
  _scrollController.addListener(_scrollListener);  
  super.initState();  
}  

// void dispose() {  
//   _scrollController.removeListener(_scrollListener);  
//   _scrollController.dispose();  
//   // _searchTextController.dispose();  
//   super.dispose();  
// }  

// Your scroll listener could also use mounted check  
_scrollListener() async {  
  if (!mounted) return; // Check if the widget is still in the tree  
  var currentPosition = _scrollController.position.pixels;  
  var maxScrollLength = _scrollController.position.maxScrollExtent;  
  if (currentPosition >= (0.7 * maxScrollLength)) {  
    if (!isLoading) {  
      isLoading = true;  
      await cubit.getProducts(pageNumber: nextPage);  
      isLoading = false;  
    }  
  }  
}

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
      _searchQuery = '';
    });
    // Implement logic to reset displayed products if needed
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
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
                    child: buildSearchBody(state),
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
    nextPage = 1;
    cubit.loadData();
  }

  Widget buildSearchBody(HomeStateLoaded state) {  
  if (state.hasMoreProductsWithPagenation) nextPage++;  

  // Filter products based on search query  
  final filteredProducts = state.products.where((product) {  
    return product.title.toLowerCase().contains(_searchQuery.toLowerCase());  
  }).toList();  

  return CustomScrollView(  
    physics: const BouncingScrollPhysics(),  
    controller: _scrollController,  
    slivers: [  
      SliverToBoxAdapter(  
        child: SearchTextField(  
          controller: _searchTextController,  
          onChanged: (value) {  
            setState(() {  
              _searchQuery = value;  
            });  
          },  
          onClear: clearSearch,  
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
      SliverToBoxAdapter(child: CategorySelector(categories: state.categories, selectedValue: (value) {
      setState(() {
        selectedCategory = value;
      });
    },)),  
      const SliverToBoxAdapter(child: SizedBox(height: 28)),  
      SliverToBoxAdapter(  
        child: TiledTitle(  
          title: 'Popular products for you',  
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
      if(!state.hasMoreProductsWithPagenation)  
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
