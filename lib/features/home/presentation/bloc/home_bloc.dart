import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeUseCase getHomeUseCase;

  HomeBloc({required this.getHomeUseCase}) : super(HomeInitial()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await getHomeUseCase(const NoParams());
        emit(HomeLoaded(data: data));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
