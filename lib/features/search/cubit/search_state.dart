part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductEntity> products;
  final bool loading;
  final String? message;
  final bool hasMoreProducts;
  bool get hasMessage => message?.isNotEmpty ?? false;
  const SearchLoaded({
    this.products = const [],
    this.loading = false,
    this.message,
    this.hasMoreProducts = false,
  });

  @override
  List<Object?> get props => [products, loading, message];

  SearchLoaded copyWith({
    List<ProductEntity>? products,
    bool? loading,
    String? message,
    bool? hasMoreProducts,
  }) {
    return SearchLoaded(
        hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
        products: products ?? this.products,
        loading: loading ?? this.loading,
        message: message);
  }
}

class SearchFailure extends SearchState {
  final String message;

  const SearchFailure({required this.message});
}
