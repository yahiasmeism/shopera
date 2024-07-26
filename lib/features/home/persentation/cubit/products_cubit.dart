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

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUsecase getProductsUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  final SearchProductsUsecase searchProductsUsecase;

  ProductsCubit({
    required this.getProductsUsecase,
    required this.getCategoriesUsecase,
    required this.getProductsByCategoryUsecase,
    required this.searchProductsUsecase,
  }) : super(ProductsStateInitial());

  /// Load initial data for products, categories, and popular products.
  Future<void> loadData() async {
    emit(const ProductsStateLoaded(loadingData: true));
    await getCategories();
    await getPopularProducts();
    await getProductsByCategory(category: 'All');
    if (state is ProductsStateLoaded) {
      final state = this.state as ProductsStateLoaded;
      emit(state.copyWith(loadingData: false));
    }
  }

  /// Fetch popular product
  Future<void> getPopularProducts() async {
    if (state is ProductsStateLoaded) {
      final state = this.state as ProductsStateLoaded;
      final result = await getProductsUsecase();
      result.fold(
        (failure) {
          emit(ProductsStateFailure(message: failure.message));
        },
        (popularProducts) {
          try {
            emit(state.copyWith(popularProduct: popularProducts.sublist(0, 5)));
          } catch (e) {
            emit(state.copyWith(message: 'Oops, there was an error. Please try again later.'));
          }
        },
      );
    }
  }

  /// Fetch products with pagination.
  Future<void> getAllProducts({int pageNumber = 0}) async {
    log('Fetching products for page number: $pageNumber');
    if (state is ProductsStateLoaded) {
      final state = this.state as ProductsStateLoaded;
      final result = await getProductsUsecase(pageNumber);
      result.fold(
        (failure) {
          if (pageNumber > 0) {
            emit(state.copyWith(hasMoreProductsWithPagination: false));
          } else {
            emit(ProductsStateFailure(message: failure.message));
          }
        },
        (newProducts) {
          if (newProducts.isEmpty) {
            emit(state.copyWith(hasMoreProductsWithPagination: false));
          } else {
            final products = List<ProductEntity>.from(state.products)..addAll(newProducts);
            emit(state.copyWith(products: products, hasMoreProductsWithPagination: true));
          }
        },
      );
    }
  }

  /// Fetch categories.
  Future<void> getCategories() async {
    if (state is ProductsStateLoaded) {
      final state = this.state as ProductsStateLoaded;
      final result = await getCategoriesUsecase(NoParams());
      result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (categories) {
          categories.insert(0, CategoryModel(name: 'All'));
          emit(state.copyWith(categories: categories));
        },
      );
    }
  }

  /// Fetch products by category with pagination.
  Future<void> getProductsByCategory({int pageNumber = 0, required String category}) async {
    if (category == 'All') {
      await getAllProducts(pageNumber: pageNumber);
    } else {
      if (state is ProductsStateLoaded) {
        final state = this.state as ProductsStateLoaded;
        final result =
            await getProductsByCategoryUsecase(ProductsByCategoryParams(categoryName: category, pageNumber: pageNumber));
        result.fold(
          (failure) => emit(ProductsStateFailure(message: failure.message)),
          (products) => emit(state.copyWith(products: products)),
        );
      }
    }
  }

  /// Search for products with pagination.
  Future<void> search({int pageNumber = 0, required String query}) async {
    if (state is ProductsStateLoaded) {
      final state = this.state as ProductsStateLoaded;
      if (pageNumber == 0) {
        emit(state.copyWith(loadingData: true));
      } else {
        emit(state.copyWith(loadingData: false));
      }
      final result = await searchProductsUsecase(SearchParams(keyword: query, pageNumber: pageNumber));
      result.fold(
        (failure) => emit(state.copyWith(message: failure.message, hasMoreProductsSearchWithPagination: false)),
        (searchProducts) {
          if (searchProducts.isEmpty) {
            emit(state.copyWith(
                hasMoreProductsSearchWithPagination: false, productsBySearch: pageNumber == 0 ? List.empty() : null));
          } else {
            final updatedProducts = pageNumber == 0 ? searchProducts : state.productsBySearch + searchProducts;
            emit(
                state.copyWith(productsBySearch: updatedProducts, loadingData: false, hasMoreProductsSearchWithPagination: true));
          }
        },
      );
    }
  }
}
