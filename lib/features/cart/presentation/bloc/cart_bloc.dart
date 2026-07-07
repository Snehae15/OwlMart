import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;

  CartBloc({required this.getCartUseCase}) : super(CartInitial()) {
    on<GetCartDataEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final data = await getCartUseCase(const NoParams());
        emit(CartLoaded(data: data));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
