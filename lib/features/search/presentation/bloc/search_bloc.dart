import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_search_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchUseCase getSearchUseCase;

  SearchBloc({required this.getSearchUseCase}) : super(SearchInitial()) {
    on<GetSearchDataEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final data = await getSearchUseCase(const NoParams());
        emit(SearchLoaded(data: data));
      } catch (e) {
        emit(SearchError(message: e.toString()));
      }
    });
  }
}
