import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase getProductUseCase;

  ProductBloc({required this.getProductUseCase}) : super(ProductInitial()) {
    on<GetProductDataEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final data = await getProductUseCase(const NoParams());
        emit(ProductLoaded(data: data));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
