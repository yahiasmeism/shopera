import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/dtos/cart_dto.dart';
import '../../data/dtos/cart_item_dto.dart';
import '../../domin/entities/cart_item.dart';
import '../../domin/entities/cart.dart';
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
  Cart? cart;

  // Method to delete an item from the cart by id
  Future<bool> deleteItem(int itemId) async {
    bool isSuccessOperation = false;

    if (cart != null) {
      final updatedItems = List<CartItem>.from(cart!.items);
      final itemIndex = updatedItems.indexWhere((item) => item.id == itemId);

      if (itemIndex != -1) {
        updatedItems.removeAt(itemIndex);
        final updatedCart = cart!.copyWith(items: updatedItems);
        return await _updateCart(id: updatedCart.id, items: CartDto.fromEntity(updatedCart).items);
      }
    }
    return isSuccessOperation;
  }

  bool containsItem(int itemId) {
    final result = cart?.items.any((item) => item.id == itemId) ?? false;
    return result;
  }

  // Method to add an item to the cart
  Future<bool> addItem(int productId) {
    if (cart == null) {
      // Create a new cart if it doesn't exist
      return _createCart(items: [CartItemDto(id: productId, quantity: 1)]);
    } else {
      // Update the existing cart
      final updatedItems = List<CartItemDto>.from(cart!.items.map((e) => CartItemDto.fromEntity(e)));
      final index = updatedItems.indexWhere((item) => item.id == productId);

      if (index != -1) {
        updatedItems[index] = CartItemDto(
          id: updatedItems[index].id,
          quantity: updatedItems[index].quantity + 1,
        );
      } else {
        updatedItems.add(CartItemDto(id: productId, quantity: 1));
      }

      return _updateCart(id: cart!.id, items: updatedItems);
    }
  }

  // Method to create a new cart
  Future<bool> _createCart({required List<CartItemDto> items}) async {
    bool isSuccessOperation = false;
    log(state.runtimeType.toString());
    final cartResult = await createCartUsecase(items);
    cartResult.fold(
      (failure) => emit(CartFailure(message: failure.message)),
      (cart) {
        this.cart = cart;
        emit(CartLoaded(cart: cart));
        isSuccessOperation = true;
      },
    );
    return isSuccessOperation;
  }

  // Method to update an existing cart
  Future<bool> _updateCart({required int id, required List<CartItemDto> items}) async {
    bool isSuccessOperation = false;
    if (state is CartLoaded) {
      final updateResult = await updateCartUsecase(
        UpdateParam(cartId: id, items: items),
      );
      updateResult.fold(
        (failure) {
          emit(CartFailure(message: failure.message));
        },
        (cart) {
          this.cart = cart;
          final loadedState = state as CartLoaded;
          emit(loadedState.copyWith(cart: cart));
          isSuccessOperation = true;
        },
      );
    }
    return isSuccessOperation;
  }

  // Method to change the quantity of an item in the cart
  void onChangeQuantitiesOfItem(int quantity, int itemId) {
    if (cart != null) {
      // Get the index of the item in the cart
      final itemIndex = cart!.items.indexWhere((item) => item.id == itemId);

      if (itemIndex != -1) {
        // Update the quantity of the item
        final updatedItem = cart!.items[itemIndex].copyWith(quantity: quantity);

        // Create a new list of items with the updated item
        final updatedItems = List<CartItem>.from(cart!.items);
        updatedItems[itemIndex] = updatedItem;

        // Create a new cart with the updated list of items
        final updatedCart = cart!.copyWith(items: updatedItems);

        // Create a DTO for the updated cart
        final cartDto = CartDto.fromEntity(updatedCart);

        // Call the updateCart method with the necessary parameters
        _updateCart(id: cart!.id, items: cartDto.items);
      }
    }
  }

  // Method to remove the cart
  Future<bool> removeCart() async {
    bool isSuccessOperation = false;
    if (cart != null) {
      final deleteResult = await deleteCartUsecase(cart!.id);
      deleteResult.fold(
        (failure) {
          emit(CartFailure(message: failure.message));
        },
        (success) {
          cart = null;
          emit(CartInitial());
          isSuccessOperation = true;
        },
      );
    }
    return isSuccessOperation;
  }
}
