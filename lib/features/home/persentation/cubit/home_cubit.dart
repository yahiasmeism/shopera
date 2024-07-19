import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domin/entities/category_entity.dart';
import '../../domin/usecases/get_categories_usecase.dart';
import '../../domin/usecases/get_products_by_category_usecase.dart';
import '../../domin/usecases/get_products_usecase.dart';
import '../../domin/usecases/search_products_usecase.dart';

import '../../domin/entities/product_entity.dart';

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
            emit(HomeStateLoaded(message: failure.message));
          } else {
            emit(HomeStateFailure(message: failure.message));
          }
        },
        (products) {
          emit(state.copyWith(products: products));
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
        (categories) => emit(state.copyWith(categoris: categories)),
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
}
