import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../../domain/usecases/get_admin_usecase.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final GetAdminUseCase getAdminUseCase;

  AdminBloc({required this.getAdminUseCase}) : super(AdminInitial()) {
    on<GetAdminDataEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        final data = await getAdminUseCase(const NoParams());
        emit(AdminLoaded(data: data));
      } catch (e) {
        emit(AdminError(message: e.toString()));
      }
    });
  }
}
