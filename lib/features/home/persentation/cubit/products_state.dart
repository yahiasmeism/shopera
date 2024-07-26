part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsStateInitial extends ProductsState {}

class ProductsStateLoaded extends ProductsState {
  final String selectedCategory;
  final bool hasMoreProductsWithPagenation;
  final bool hasMoreProductsSearchWithPagenation;
  final bool loadingData;
  final List<ProductEntity> popularProduct;
  final List<ProductEntity> products;
  final List<ProductEntity> productsBySearch;
  final List<CategoryEntity> categories;
  final String? message;
  const ProductsStateLoaded({
    this.selectedCategory = 'all',
    this.hasMoreProductsWithPagenation = false,
    this.hasMoreProductsSearchWithPagenation = false,
    this.loadingData = false,
    this.popularProduct = const [],
    this.products = const [],
    this.productsBySearch = const [],
    this.categories = const [],
    this.message,
  });
  bool get hasMessage => message?.isNotEmpty ?? false;
  ProductsStateLoaded copyWith({
    String? selectedCategory,
    bool? hasMoreProductsWithPagination,
    bool? hasMoreProductsSearchWithPagination,
    String? message,
    bool? loadingData,
    List<ProductEntity>? products,
    List<ProductEntity>? productsBySearch,
    List<ProductEntity>? popularProduct,
    List<CategoryEntity>? categories,
  }) {
    return ProductsStateLoaded(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      popularProduct: popularProduct ?? this.popularProduct,
      hasMoreProductsWithPagenation: hasMoreProductsWithPagination ?? hasMoreProductsWithPagenation,
      hasMoreProductsSearchWithPagenation: hasMoreProductsSearchWithPagination ?? hasMoreProductsSearchWithPagenation,
      message: message,
      loadingData: loadingData ?? this.loadingData,
      products: products ?? this.products,
      productsBySearch: productsBySearch ?? this.productsBySearch,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props {
    return [
      selectedCategory,
      hasMoreProductsWithPagenation,
      loadingData,
      popularProduct,
      products,
      productsBySearch,
      categories,
      message,
    ];
  }
}

final class ProductsStateFailure extends ProductsState {
  final String message;

  const ProductsStateFailure({required this.message});
}

final class ProductsStateLoading extends ProductsState {}
