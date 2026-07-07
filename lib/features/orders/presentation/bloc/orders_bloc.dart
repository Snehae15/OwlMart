import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersBloc({required this.getOrdersUseCase}) : super(OrdersInitial()) {
    on<GetOrdersDataEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        final data = await getOrdersUseCase(const NoParams());
        emit(OrdersLoaded(data: data));
      } catch (e) {
        emit(OrdersError(message: e.toString()));
      }
    });
  }
}
