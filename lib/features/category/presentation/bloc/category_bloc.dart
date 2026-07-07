import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_category_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;

  CategoryBloc({required this.getCategoryUseCase}) : super(CategoryInitial()) {
    on<GetCategoryDataEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final data = await getCategoryUseCase(const NoParams());
        emit(CategoryLoaded(data: data));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
  }
}
