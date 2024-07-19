part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeStateInitial extends HomeState {}

class HomeStateLoaded extends HomeState {
  final bool productsLoaded;
  final bool categoriesLoaded;
  final List<ProductEntity> products;
  final List<ProductEntity> productsBySearch;
  final List<ProductEntity> productsBycategory;
  final List<CategoryEntity> categoris;
  final String? message;
  const HomeStateLoaded({
    this.categoriesLoaded = false,
    this.productsLoaded = false,
    this.message,
    this.products = const [],
    this.productsBySearch = const [],
    this.categoris = const [],
    this.productsBycategory = const [],
  });

  HomeStateLoaded copyWith({
    String? message,
    bool? productsLoaded,
    bool? categoriesLoaded,
    List<ProductEntity>? products,
    List<ProductEntity>? productsBySearch,
    List<ProductEntity>? productsBycategory,
    List<CategoryEntity>? categoris,
  }) {
    return HomeStateLoaded(
      message: message ?? this.message,
      productsLoaded: productsLoaded ?? this.productsLoaded,
      categoriesLoaded: categoriesLoaded ?? this.categoriesLoaded,
      products: products ?? this.products,
      productsBySearch: productsBySearch ?? this.productsBySearch,
      productsBycategory: productsBycategory ?? this.productsBycategory,
      categoris: categoris ?? this.categoris,
    );
  }

  @override
  List<Object?> get props {
    return [
      productsLoaded,
      categoriesLoaded,
      products,
      productsBySearch,
      productsBycategory,
      categoris,
      message,
    ];
  }
}

final class HomeStateFailure extends HomeState {
  final String message;

  const HomeStateFailure({required this.message});
}

final class HomeStateLoading extends HomeState {}
