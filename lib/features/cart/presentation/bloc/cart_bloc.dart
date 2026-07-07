import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_quantity_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(const CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveItemFromCartEvent>(_onRemoveItemFromCart);
    on<UpdateItemQuantityEvent>(_onUpdateItemQuantity);
    on<ClearCartItemsEvent>(_onClearCartItems);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      final items = await getCartUseCase(event.userId);
      final totalPrice = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
      emit(CartLoaded(items: items, totalPrice: totalPrice));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddItemToCart(AddItemToCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      await addToCartUseCase(AddToCartParams(userId: event.userId, item: event.item));
      emit(const CartOperationSuccess(message: 'Item added to cart'));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onRemoveItemFromCart(RemoveItemFromCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      await removeFromCartUseCase(RemoveFromCartParams(userId: event.userId, productId: event.productId));
      emit(const CartOperationSuccess(message: 'Item removed from cart'));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onUpdateItemQuantity(UpdateItemQuantityEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      await updateCartQuantityUseCase(
        UpdateCartQuantityParams(
          userId: event.userId,
          productId: event.productId,
          quantity: event.quantity,
        ),
      );
      emit(const CartOperationSuccess(message: 'Quantity updated'));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onClearCartItems(ClearCartItemsEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      await clearCartUseCase(event.userId);
      emit(const CartOperationSuccess(message: 'Cart cleared'));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
