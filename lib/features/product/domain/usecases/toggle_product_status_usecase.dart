import 'package:equatable/equatable.dart';
import 'package:owlmart/core/usecase/usecase.dart';
import '../repository/product_repository.dart';

class ToggleProductStatusUseCase implements UseCase<void, ToggleProductStatusParams> {
  final ProductRepository repository;

  const ToggleProductStatusUseCase({required this.repository});

  @override
  Future<void> call(ToggleProductStatusParams params) async {
    return repository.toggleProductStatus(params.id, params.isEnabled);
  }
}

class ToggleProductStatusParams extends Equatable {
  final String id;
  final bool isEnabled;

  const ToggleProductStatusParams({required this.id, required this.isEnabled});

  @override
  List<Object?> get props => [id, isEnabled];
}
