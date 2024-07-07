import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopera/features/cart/data/dtos/cart_dto.dart';
import 'package:shopera/features/cart/data/dtos/cart_item_dto.dart';
import 'package:shopera/features/cart/domin/entities/cart_item_entity.dart';

import '../../domin/entities/cart_entity.dart';
import '../../domin/usecases/create_cart_usecase.dart';
import '../../domin/usecases/delete_cart_usecase.dart';
import '../../domin/usecases/update_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CreateCartUsecase createCartUsecase;
  final UpdateCartUsecase updateCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;

  CartCubit({
    required this.updateCartUsecase,
    required this.createCartUsecase,
    required this.deleteCartUsecase,
  }) : super(CartInitial());

  // The current cart entity
  CartEntity? _cart;

  // Method to delete an item from the cart by index
  void deleteItem(int index) {
    if (state is CartLoaded) {
      final stateLoaded = state as CartLoaded;
      final updatedItems = List<CartItemEntity>.from(stateLoaded.cart.items);
      final updatedCart = stateLoaded.cart.copyWith(items: updatedItems);
      updatedItems.removeAt(index);
      _updateCart(id: updatedCart.id, cartDto: CartDto.fromEntity(updatedCart));
    }
  }

  // Method to add an item to the cart
  addItem({required int userId, required int productId}) {
    if (_cart == null) {
      // Create a new cart if it doesn't exist
      final cartDto = CartDto(
        userId: userId,
        items: [CartItemDto(id: productId, quantity: 1)],
      );
      _createCart(cartDto: cartDto);
    } else {
      // Update the existing cart
      final updatedItems = List<CartItemDto>.from(
          _cart!.items.map((e) => CartItemDto.fromEntity(e)));
      final index = updatedItems.indexWhere((item) => item.id == productId);

      if (index != -1) {
        updatedItems[index] = CartItemDto(
          id: updatedItems[index].id,
          quantity: updatedItems[index].quantity + 1,
        );
      } else {
        updatedItems.add(CartItemDto(id: productId, quantity: 1));
      }

      final cartDto = CartDto(
        items: updatedItems,
      );
      _updateCart(id: _cart!.id, cartDto: cartDto);
    }
  }

  // Method to create a new cart
  Future<void> _createCart({required CartDto cartDto}) async {
    final cartResult = await createCartUsecase(cartDto);
    cartResult.fold(
      (failure) => emit(CartFailure(message: failure.message)),
      (cart) {
        _cart = cart;
        emit(CartLoaded(cart: cart));
      },
    );
  }

  // Method to update an existing cart
  _updateCart({required int id, required CartDto cartDto}) async {
    if (state is CartLoaded) {
      final updateResult = await updateCartUsecase(
        UpdateParam(cartId: id, cartDto: cartDto),
      );
      updateResult.fold(
        (failure) => emit(CartFailure(message: failure.message)),
        (cart) {
          _cart = cart;
          final loadedState = state as CartLoaded;
          emit(loadedState.copyWith(cart: cart));
        },
      );
    }
  }

  // Method to change the quantity of an item in the cart
  void onChangeQuantitiesOfItem(int quantity, int itemId) {
    if (_cart != null) {
      // Get the index of the item in the cart
      final itemIndex = _cart!.items.indexWhere((item) => item.id == itemId);

      if (itemIndex != -1) {
        // Update the quantity of the item
        final updatedItem =
            _cart!.items[itemIndex].copyWith(quantity: quantity);

        // Create a new list of items with the updated item
        final updatedItems = List<CartItemEntity>.from(_cart!.items);
        updatedItems[itemIndex] = updatedItem;

        // Create a new cart with the updated list of items
        final updatedCart = _cart!.copyWith(items: updatedItems);

        // Create a DTO for the updated cart (assuming you have a DTO class)
        final cartDto = CartDto.fromEntity(updatedCart);

        // Call the updateCart method with the necessary parameters
        _updateCart(id: _cart!.id, cartDto: cartDto);
      }
    }
  }
}
