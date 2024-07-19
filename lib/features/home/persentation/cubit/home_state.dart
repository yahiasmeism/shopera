part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeStateInitial extends HomeState {}

class HomeStateLoaded extends HomeState {
  final bool loadingData;
  final List<ProductEntity> products;
  final List<ProductEntity> productsBySearch;
  final List<ProductEntity> productsBycategory;
  final List<CategoryEntity> categoris;
  final String? message;
  const HomeStateLoaded({
    this.loadingData = false,
    this.message,
    this.products = const [],
    this.productsBySearch = const [],
    this.categoris = const [],
    this.productsBycategory = const [],
  });

  HomeStateLoaded copyWith({
    String? message,
    bool? loadingData,
    List<ProductEntity>? products,
    List<ProductEntity>? productsBySearch,
    List<ProductEntity>? productsBycategory,
    List<CategoryEntity>? categoris,
  }) {
    return HomeStateLoaded(
      message: message,
      loadingData: loadingData ?? this.loadingData,
      products: products ?? this.products,
      productsBySearch: productsBySearch ?? this.productsBySearch,
      productsBycategory: productsBycategory ?? this.productsBycategory,
      categoris: categoris ?? this.categoris,
    );
  }

  @override
  List<Object?> get props {
    return [
      loadingData,
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
