import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;

  WishlistBloc({required this.getWishlistUseCase}) : super(WishlistInitial()) {
    on<GetWishlistDataEvent>((event, emit) async {
      emit(WishlistLoading());
      try {
        final data = await getWishlistUseCase(const NoParams());
        emit(WishlistLoaded(data: data));
      } catch (e) {
        emit(WishlistError(message: e.toString()));
      }
    });
  }
}
