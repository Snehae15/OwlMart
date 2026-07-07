import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_wishlist_usecase.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/remove_from_wishlist_usecase.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishlistBloc({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
  }) : super(const WishlistInitial()) {
    on<LoadWishlistEvent>(_onLoadWishlist);
    on<AddItemToWishlistEvent>(_onAddItemToWishlist);
    on<RemoveItemFromWishlistEvent>(_onRemoveItemFromWishlist);
  }

  Future<void> _onLoadWishlist(LoadWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(const WishlistLoading());
    try {
      final items = await getWishlistUseCase(event.userId);
      emit(WishlistLoaded(items: items));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onAddItemToWishlist(AddItemToWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(const WishlistLoading());
    try {
      await addToWishlistUseCase(AddToWishlistParams(userId: event.userId, item: event.item));
      emit(const WishlistOperationSuccess(message: 'Item added to wishlist'));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onRemoveItemFromWishlist(RemoveItemFromWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(const WishlistLoading());
    try {
      await removeFromWishlistUseCase(RemoveFromWishlistParams(userId: event.userId, productId: event.productId));
      emit(const WishlistOperationSuccess(message: 'Item removed from wishlist'));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }
}
