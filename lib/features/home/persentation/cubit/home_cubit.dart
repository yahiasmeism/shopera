import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopera/features/home/data/models/category_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domin/entities/category_entity.dart';
import '../../domin/entities/product_entity.dart';
import '../../domin/usecases/get_categories_usecase.dart';
import '../../domin/usecases/get_products_by_category_usecase.dart';
import '../../domin/usecases/get_products_usecase.dart';
import '../../domin/usecases/search_products_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUsecase getProductsUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  final SearchProductsUsecase searchProductsUsecase;
  HomeCubit({
    required this.getProductsUsecase,
    required this.getCategoriesUsecase,
    required this.getProductsByCategoryUsecase,
    required this.searchProductsUsecase,
  }) : super(HomeStateInitial());

  loadData() async {
    emit(const HomeStateLoaded(loadingData: true));
    await getProducts();
    await getCategoris();
    if (state is HomeStateLoaded) {
      final state = this.state as HomeStateLoaded;
      emit(state.copyWith(loadingData: false));
    }
  }

  Future getProducts({int pageNumber = 0}) async {
    log(pageNumber.toString());
    if (state is HomeStateLoaded) {
      final state = this.state as HomeStateLoaded;
      final result = await getProductsUsecase(pageNumber);
      result.fold(
        (failure) {
          if (pageNumber > 0) {
            emit(state.copyWith(hasMoreProductsWithPagenation: false));
          } else {
            emit(HomeStateFailure(message: failure.message));
          }
        },
        (newProducts) {
          if (newProducts.isEmpty) {
            emit(state.copyWith(hasMoreProductsWithPagenation: false));
          } else {
            final products = List<ProductEntity>.from(state.products)..addAll(newProducts);
            emit(state.copyWith(products: products, hasMoreProductsWithPagenation: true));
          }
        },
      );
    }
  }

  Future getCategoris() async {
    if (state is HomeStateLoaded) {
      final state = this.state as HomeStateLoaded;
      final result = await getCategoriesUsecase(NoParams());
      result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (categories) {
          categories.insert(0,CategoryModel(name: 'All'));
          emit(state.copyWith(categoris: categories));
        },
      );
    }
  }

  Future getProductsByCategory({int pageNumber = 0, required String category}) async {
    if (state is HomeStateLoaded) {
      final state = this.state as HomeStateLoaded;
      final result =
          await getProductsByCategoryUsecase.call(ProductsByCategoryParams(categoryName: category, pageNumber: pageNumber));
      result.fold(
        (failure) => emit(HomeStateFailure(message: failure.message)),
        (products) => emit(state.copyWith(productsBycategory: products)),
      );
    }
  }

  Future onSearch({int pageNumber = 0, required String keyword}) async {
    if (state is HomeStateLoaded) {
      final state = this.state as HomeStateLoaded;
      final result = await searchProductsUsecase(SearchParams(keyword: keyword, pageNumber: pageNumber));
      result.fold(
        (failure) => emit(HomeStateFailure(message: failure.message)),
        (products) => emit(state.copyWith(productsBySearch: products)),
      );
    }
  }


  // productToggleCart({required ProductEntity product, required bool added}) async {
  //   final SharedPreferences sharedPref = AppDep.sl();
  //   if (!sharedPref.containsKey(K_U_ID) || sharedPref.getInt(K_U_ID) == null) return;
  //   if (added) {
  //     cartCubit.addItem(productId: product.id);
  //   } else {
  //     cartCubit.deleteItem(product.id);
  //   }
  // }
}
