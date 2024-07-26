import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shopera/features/home/domin/entities/product_entity.dart';

import '../../home/domin/usecases/search_products_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUsecase searchProductsUsecase;
  SearchCubit(
    this.searchProductsUsecase,
  ) : super(const SearchLoaded());

  /// Search for products with pagination.
  Future<void> search({int pageNumber = 0, required String query}) async {
    if (state is SearchLoaded) {
      final state = this.state as SearchLoaded;
      if (pageNumber == 0) {
        emit(state.copyWith(loading: true));
      } else {
        emit(state.copyWith(loading: false));
      }
      final result = await searchProductsUsecase(SearchParams(keyword: query, pageNumber: pageNumber));
      result.fold(
        (failure) => emit(SearchFailure(message: failure.message)),
        (searchProducts) {
          if (searchProducts.isEmpty) {
            emit(state.copyWith(hasMoreProducts: false, products: pageNumber == 0 ? List.empty() : null));
          } else {
            final updatedProducts = pageNumber == 0 ? searchProducts : state.products + searchProducts;
            emit(state.copyWith(products: updatedProducts, loading: false, hasMoreProducts: true));
          }
        },
      );
    }
  }
}
